import 'package:flutter/material.dart';

import '../widgets/menu_card.dart';
import 'piramida_screen.dart';
import 'segitiga_screen.dart';
import 'konversi_waktu_screen.dart';
import 'cek_hari_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bangun Datar & Utilitas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            MenuCard(
              title: 'Piramida',
              icon: Icons.change_history,
              onTap: () => _open(context, const PiramidaScreen()),
            ),
            MenuCard(
              title: 'Segitiga',
              icon: Icons.signal_cellular_4_bar,
              onTap: () => _open(context, const SegitigaScreen()),
            ),
            MenuCard(
              title: 'Konversi Waktu',
              icon: Icons.access_time,
              onTap: () => _open(context, const KonversiWaktuScreen()),
            ),
            MenuCard(
              title: 'Cek Hari',
              icon: Icons.calendar_today,
              onTap: () => _open(context, const CekHariScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
