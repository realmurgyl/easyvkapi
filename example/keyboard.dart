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
    String type = event["type"];

    if (type == "message_new") {
      String text = event["object"]["message"]["text"].toLowerCase();
      int userId = event["object"]["message"]["from_id"];

      if (text == "btn1") {
        //кнопка в сообщении
        Keyboard keyboard = Keyboard(oneTime: false, inline: true);
        keyboard.addButton("text", color: KeyboardColors.negative);

        await vkApi.method("messages.send", {
          "peer_id": userId,
          "random_id": 0,
          "message": "text",
          "keyboard": keyboard.getKeyboard()
        });
      }

      if (text == "btn2") {
        //кнопка снизу
        Keyboard keyboard = Keyboard(oneTime: false, inline: false);
        keyboard.addButton("text");

        await vkApi.method("messages.send", {
          "peer_id": userId,
          "random_id": 0,
          "message": "text",
          "keyboard": keyboard.getKeyboard()
        });
      }

      if (text == "btn3") {
        //2 кнопки в сообщении
        Keyboard keyboard = Keyboard(oneTime: false, inline: true);
        keyboard.addButton("text");
        keyboard.addLine();
        keyboard.addButton("text");

        await vkApi.method("messages.send", {
          "peer_id": userId,
          "random_id": 0,
          "message": "text",
          "keyboard": keyboard.getKeyboard()
        });
      }

      if (text == "btn4") {
        //ссылка в кнопке
        //так же и с нижней клавиатурой (inline: false)
        Keyboard keyboard = Keyboard(oneTime: false, inline: true);
        keyboard.addOpenLinkButton("text", "https://google.com/");

        await vkApi.method("messages.send", {
          "peer_id": userId,
          "random_id": 0,
          "message": "text",
          "keyboard": keyboard.getKeyboard()
        });
      }
    }
  });
}
