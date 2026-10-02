import 'dart:math';

import 'package:flutter/material.dart';

class SegitigaScreen extends StatefulWidget {
  const SegitigaScreen({super.key});

  @override
  State<SegitigaScreen> createState() => _SegitigaScreenState();
}

class _SegitigaScreenState extends State<SegitigaScreen> {
  final List<String> _jenis = ['Sama Kaki', 'Sama Sisi', 'Siku-siku'];
  String _terpilih = 'Sama Kaki';

  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  String _hasil = '';

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    super.dispose();
  }

  // Label input menyesuaikan jenis segitiga
  List<String> get _labels {
    switch (_terpilih) {
      case 'Sama Kaki':
        return ['Alas', 'Sisi kaki', 'Tinggi'];
      case 'Sama Sisi':
        return ['Panjang sisi'];
      default:
        return ['Alas', 'Tinggi'];
    }
  }

  void _hitung() {
    final a = double.tryParse(_c1.text);
    final b = double.tryParse(_c2.text);
    final c = double.tryParse(_c3.text);
    double luas;
    double keliling;
    String extra = '';

    switch (_terpilih) {
      case 'Sama Kaki':
        if (a == null || b == null || c == null || a <= 0 || b <= 0 || c <= 0) {
          return _error();
        }
        luas = 0.5 * a * c;
        keliling = a + 2 * b;
        break;
      case 'Sama Sisi':
        if (a == null || a <= 0) return _error();
        luas = (sqrt(3) / 4) * a * a;
        keliling = 3 * a;
        break;
      default: // Siku-siku
        if (a == null || b == null || a <= 0 || b <= 0) return _error();
        final miring = sqrt(a * a + b * b);
        luas = 0.5 * a * b;
        keliling = a + b + miring;
        extra = '\nSisi miring = ${miring.toStringAsFixed(2)}';
    }

    setState(() {
      _hasil =
          'Luas = ${luas.toStringAsFixed(2)}\n'
          'Keliling = ${keliling.toStringAsFixed(2)}$extra';
    });
  }

  void _error() {
    setState(() => _hasil = 'Masukkan angka yang valid (lebih dari 0).');
  }

  Widget _field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = _labels;
    final controllers = [_c1, _c2, _c3];

    return Scaffold(
      appBar: AppBar(title: const Text('Segitiga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _terpilih,
              decoration: const InputDecoration(
                labelText: 'Jenis segitiga',
                border: OutlineInputBorder(),
              ),
              items: _jenis
                  .map((j) => DropdownMenuItem(value: j, child: Text(j)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _terpilih = value!;
                  _hasil = '';
                  for (final c in controllers) {
                    c.clear();
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < labels.length; i++)
              _field(controllers[i], labels[i]),
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
