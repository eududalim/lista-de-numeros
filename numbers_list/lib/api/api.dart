import 'package:url_launcher/url_launcher.dart';

class WhatsAppApi {
  ///Implementar esta função corretamente!
  static abrirWhatsApp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=+55$phone";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Aplicativo não encontrado';
    }
  }
}
