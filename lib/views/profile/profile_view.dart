import 'package:flutter/material.dart';
import 'package:shopyy/core/utils/fixed.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mitt konto',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              tileColor: Colors.black87,
              horizontalTitleGap: 0,
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
              ),
              title: const Text(
                'Samama Majeed',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'sam@gmail.com',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '0342-XXXXXXX',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const VerticalSpace(
              h: 30,
            ),
            const ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Kontoinstallningar'),
            ),
            ListTile(
              leading: Image.asset('lib/assets/icons/min.png'),
              title: const Text('Mina betalmetoder'),
            ),
            ListTile(
              leading: Image.asset('lib/assets/icons/football.png'),
              title: const Text('Support'),
            )
          ],
        ),
      ),
    );
  }
}
