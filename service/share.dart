import 'package:portfolio/models/shareParams.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

enum Platform {
  facebook,
  kakao,
  gmail,
  email,
  text,
}

class ShareService {
  final Map<Platform, String> _urls = {
    Platform.gmail: "gmail.com",
  };

  Future<void> share({required Platform platform, ShareParams? params}) async {
    String _url = "";
    if (platform == Platform.email) {
      ShareViaEmail _params = params as ShareViaEmail;
      _url = "mailto:${_params.email.toString()}?subject=${_params.title.toString()}&body=${_params.body.toString()}";
    } else if (platform == Platform.text) {
      ShareViaText _params = params as ShareViaText;
      _url = "sms:${_params.number}?body=${_params.body}";
    } else {
      _url = "https://${this._urls[platform].toString()}";
    }
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      print("error");
      throw "failed";
    }
  }

  Future<void> copyText({required String text}) async {
    await FlutterClipboard.copy(text);
  }

}
