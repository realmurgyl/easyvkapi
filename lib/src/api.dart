import 'package:http/http.dart' as http;
import 'dart:convert';

class VKApi {
  final String _baseMethodUrl = 'https://api.vk.com/method';
  late String _token;
  late String _version;

  VKApi({required String token, String version = "5.154"}) {
    _token = token;
    _version = version;
  }

  Future<Map> method(String method, Map args) async {
    return await _apiRequest(method, args);
  }

  String _arguments(Map args) {
    return args.entries
        .map((object) => '${object.key}=${object.value}')
        .join('&');
  }

  Future<Map> _apiRequest(String method, Map args) async {
    return await http
        .get(Uri.parse(
            "$_baseMethodUrl/$method?access_token=$_token&${_arguments(args)}&v=$_version"))
        .then((value) => json.decode(value.body));
  }
}
