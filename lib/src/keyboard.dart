import 'dart:convert';

class KeyboardColors {
  static final String primary = "primary";
  static final String secondary = "secondary";
  static final String positive = "positive";
  static final String negative = "negative";
}

class Keyboard {
  late bool oneTime;
  late bool inline;

  late List<List<dynamic>> lines = [[]];
  late Map keyboard = {"one_time": oneTime, "inline": inline, "buttons": lines};

  late int maxButtonsOnLine = 5;
  late int maxDefaultLines = 10;
  late int maxInlineLines = 6;

  Keyboard({required this.oneTime, required this.inline});

  String getKeyboard() => json.encode(keyboard);

  void addLine() => lines.add([]);

  void addButton(String label,
      {dynamic buttonType = 'text',
      String color = 'default',
      dynamic payload}) {
    List<dynamic> currentLine = lines.last;
    currentLine.add({
      "action": {"type": buttonType, "label": label, "payload": payload},
      "color": color
    });
  }

  void addOpenLinkButton(String label, dynamic link, {dynamic payload}) {
    List<dynamic> currentLine = lines.last;
    currentLine.add({
      "action": {
        "type": "open_link",
        "link": link,
        "label": label,
        "payload": payload
      }
    });
  }
}
