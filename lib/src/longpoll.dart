import 'package:http/http.dart' as http;
import 'package:easyvkapi/src/api.dart';

import 'dart:convert';
import 'dart:async';

class VKGroupLongpoll {
  late VKApi _vkApi;
  late int _groupId;

  late int _wait;
  late String _server;
  late String _key;
  late int _ts;

  final StreamController<Map> _updateController = StreamController<Map>();

  VKGroupLongpoll({required VKApi vkApi, required int groupId, int wait = 25}) {
    _vkApi = vkApi;
    _groupId = groupId;
    _wait = wait;
  }

  Stream<Map> polling() => _updateController.stream;

  Future<void> _setup() async {
    Map response = await _vkApi.method("groups.getLongPollServer",
        {"group_id": _groupId}).then((value) => value["response"]);

    _key = response["key"];
    _ts = int.parse(response["ts"]);
    _server = response["server"];
  }

  Future<Map> _getUpdate() async {
    try {
      Map event = await http
          .get(Uri.parse("$_server?act=a_check&key=$_key&ts=$_ts&wait=$_wait"))
          .then((value) => json.decode(value.body));
      if (event["failed"] != null) {
        event["failed"] == 1 ? _ts = int.parse(event["ts"]) : _ts = _ts;
        event["failed"] == 2 || event["failed"] == 3 ? await _setup() : true;
      } else {
        _ts = int.parse(event["ts"]);
        return event;
      }

      return {"updates": []};
    } catch (e) {
      return {"updates": []};
    }
  }

  Future<void> startPolling() async {
    await _setup();
    while (true) {
      Map event = await _getUpdate();
      if (event["updates"].isNotEmpty) {
        event = event["updates"][0];
        if (event["type"] == "message_new") {
          String text = event["object"]["message"]["text"];
          event["object"]["message"]["text"] = utf8.decode(text.runes.toList());
        }
        _updateController.add(event);
      }
    }
  }
}
