import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // GANTI dengan data dirimu
  static const String nama = 'Angga Baradyan';
  static const String nim = '124240065';
  static const String ttl = 'Kota, 1 Januari 2004';
  static const String hobi = 'Membaca, Coding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('lib/assets/images/foto_profil.jpeg'),
            ),
            const SizedBox(height: 24),
            const _InfoTile(icon: Icons.person, label: 'Nama', value: nama),
            const _InfoTile(icon: Icons.badge, label: 'NIM', value: nim),
            const _InfoTile(
              icon: Icons.cake,
              label: 'Tempat, Tanggal Lahir',
              value: ttl,
            ),
            const _InfoTile(icon: Icons.favorite, label: 'Hobi', value: hobi),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label, style: const TextStyle(fontSize: 12)),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
