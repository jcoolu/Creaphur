import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class KoFi extends StatelessWidget {
  const KoFi({
    super.key,
  });

  void _launchURL() async {
    Uri koFiUrl = Uri.parse('https://ko-fi.com/V7V7YQLCP');
    if (await canLaunchUrl(koFiUrl)) {
      await launchUrl(koFiUrl);
    } else {
      throw 'Could not launch $koFiUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Image.asset('lib/common/assets/kofi_button_blue.png'),
    );
  }
}
