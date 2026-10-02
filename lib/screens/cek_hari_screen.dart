import 'package:flutter/material.dart';

class CekHariScreen extends StatefulWidget {
  const CekHariScreen({super.key});

  @override
  State<CekHariScreen> createState() => _CekHariScreenState();
}

class _CekHariScreenState extends State<CekHariScreen> {
  final _controller = TextEditingController();
  String _hasil = '';

  static const List<String> _hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _cek() {
    final nomor = int.tryParse(_controller.text);

    if (nomor == null || nomor < 1 || nomor > 7) {
      setState(() => _hasil = 'Masukkan angka 1 sampai 7.');
      return;
    }

    setState(() => _hasil = 'Hari ke-$nomor adalah ${_hari[nomor - 1]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Hari')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nomor hari (1 = Senin ... 7 = Minggu)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cek,
                child: const Text('Cek Hari'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _hasil,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
