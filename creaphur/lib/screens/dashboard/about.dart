import 'package:creaphur/widgets/ko_fi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void launchMailClient(String targetEmail) async {
    String mailUrl = 'mailto:$targetEmail';
    try {
      await launchUrlString(mailUrl);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: targetEmail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Center(
            child: Image.asset(
              'lib/common/assets/logo.png',
              height: 100,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Creaphur',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const Divider(height: 30, thickness: 1),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black,
              ),
              children: [
                const TextSpan(
                  text:
                      'Creaphur is a versatile project management app designed to help you efficiently track and manage your projects. With Creaphur, you can easily log project materials, track time spent, manage expenses, and monitor progress. New features will be added for Creaphur and this page will be updated as new versions come out.\nIf you have any issues or any new ideas while using Creaphur, please do not hesitate to reach out to my email at ',
                ),
                TextSpan(
                  text: 'gjellygrump@gmail.com',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchMailClient('gjellygrump@gmail.com');
                    },
                ),
                const TextSpan(
                  text: '.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Features:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const BulletPoint(text: 'Log project materials'),
          const BulletPoint(text: 'Track time spent on tasks'),
          const BulletPoint(text: 'Manage project expenses'),
          const BulletPoint(text: 'Monitor project progress'),
          const BulletPoint(text: 'User-friendly interface'),
          const Spacer(),
          const Text(
            'Development Team:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const BulletPoint(
              text: 'Developer: Jamie Coulombe (Ginger Jellygrump)'),
          const BulletPoint(text: 'QA Analyst/Tester: Kirby'),
          const SizedBox(height: 20),
          const KoFi(),
          const SizedBox(height: 20),
          Center(
            child: Text(
              '© 2024 Creaphur',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Color(0xffad99ff)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
