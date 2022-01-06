abstract class ShareParams {}

class ShareViaEmail extends ShareParams {
  String? email;
  String? title;
  String body;

  ShareViaEmail({this.email = "", this.title = "", required this.body});
}

class ShareViaText extends ShareParams {
  String? number;
  String body;

  ShareViaText({this.number = "", required this.body});
}