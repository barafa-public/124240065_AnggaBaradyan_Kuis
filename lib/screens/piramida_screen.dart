import 'package:flutter/material.dart';

// Piramida dengan alas persegi.
class PiramidaScreen extends StatefulWidget {
  const PiramidaScreen({super.key});

  @override
  State<PiramidaScreen> createState() => _PiramidaScreenState();
}

class _PiramidaScreenState extends State<PiramidaScreen> {
  final _sisiController = TextEditingController();
  final _tinggiController = TextEditingController();
  String _hasil = '';

  @override
  void dispose() {
    _sisiController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  void _hitung() {
    final sisi = double.tryParse(_sisiController.text);
    final tinggi = double.tryParse(_tinggiController.text);

    if (sisi == null || tinggi == null || sisi <= 0 || tinggi <= 0) {
      setState(() => _hasil = 'Masukkan angka yang valid (lebih dari 0).');
      return;
    }

    final volume = (1 / 3) * sisi * sisi * tinggi; // 1/3 x luas alas x tinggi
    final keliling = 4 * sisi; // keliling alas persegi

    setState(() {
      _hasil =
          'Volume = ${volume.toStringAsFixed(2)}\n'
          'Keliling alas = ${keliling.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Piramida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _sisiController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Sisi alas (persegi)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Tinggi piramida',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hitung,
                child: const Text('Hitung'),
              ),
            ),
            const SizedBox(height: 24),
            Text(_hasil, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
