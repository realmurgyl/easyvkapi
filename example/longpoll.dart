import 'package:easyvkapi/easyvkapi.dart';

void main() async {
  print("Стартуем!");
  String token = "";
  int groupId = 0;

  VKApi vkApi = VKApi(token: token);
  VKGroupLongpoll vkGroupLongpoll =
      VKGroupLongpoll(vkApi: vkApi, groupId: groupId);

  vkGroupLongpoll.startPolling();
  vkGroupLongpoll.polling().listen((event) async {
    print(event);
  });

  /*
  while (true) {
    //Какой то код для обработки чего либо ежесекундно
    await Future.delayed(Duration(seconds: 1));
  }
  */
}
