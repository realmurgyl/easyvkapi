import 'package:easyvkapi/easyvkapi.dart';

void main() async {
  print("Стартуем!");
  String token = "";

  VKApi vkApi = VKApi(token: token);
  Map user = await vkApi.method("users.get", {"user_ids": 1});
  print(user);
}
