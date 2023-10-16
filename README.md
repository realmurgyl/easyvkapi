<h1>EasyVKApi</h1>
EasyVKApi -- максимально простая и удобная (по моему мнению) библиотека для работы с VK API.

• [Примеры](https://github.com/realmurgyl/easyvkapi/tree/main/example)

• [Документация VK API](https://dev.vk.com/ru/reference)


<h1>Установка</h1>
```bash
dart pub add easyvkapi
```

<h1>Примеры</h1>
• Запросы к VK API
```dart
import "package:easyvkapi/easyvkapi.dart";

void main() async {
  String token = "";
  VKApi vkApi = VKApi(token: token);

  Map user = await vkApi.method("users.get", {"user_ids": 1});
  print(user);
}

```

• LongPolling
```dart
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
}
```
