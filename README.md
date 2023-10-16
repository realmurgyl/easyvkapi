# EasyVKApi

EasyVKApi -- простая и легковесная библиотека для работы с VK API.

## Ccылки

[(Примеры)](https://github.com/realmurgyl/easyvkapi/tree/main/example)
[(Документация VK API)](https://dev.vk.com/ru/reference)

## Установка

[pub](https://google.com)

## Примеры

### VK Api

```dart
import "package:easyvkapi/easyvkapi.dart";

void main() async {
  String token = "";
  VKApi vkApi = VKApi(token: token);

  Map user = await vkApi.method("users.get", {"user_ids": 1});
  print(user);
}

```


### Longpoll

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
