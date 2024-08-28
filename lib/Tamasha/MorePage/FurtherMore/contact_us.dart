import 'package:url_launcher/url_launcher.dart';

class ExternalAppsHelper {
  static Future<void> openWhatsapp(String phoneNumber) async {
    final whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not open WhatsApp';
    }
  }
}
