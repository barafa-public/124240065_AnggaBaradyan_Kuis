import 'package:flutter/material.dart';

// Input waktu dalam WIB (UTC+7), lalu dikonversi ke:
// - Malaysia (UTC+8)
// - Toronto, Kanada (UTC-5 EST, atau UTC-4 saat musim panas / EDT)
class KonversiWaktuScreen extends StatefulWidget {
  const KonversiWaktuScreen({super.key});

  @override
  State<KonversiWaktuScreen> createState() => _KonversiWaktuScreenState();
}

class _KonversiWaktuScreenState extends State<KonversiWaktuScreen> {
  TimeOfDay _waktu = const TimeOfDay(hour: 12, minute: 0);
  bool _musimPanas = false; // false = EST (UTC-5), true = EDT (UTC-4)

  Future<void> _pilihWaktu() async {
    final picked = await showTimePicker(context: context, initialTime: _waktu);
    if (picked != null) setState(() => _waktu = picked);
  }

  // Mengubah waktu WIB ke zona lain berdasarkan selisih offset UTC.
  String _konversi(int offsetTujuan) {
    const offsetWib = 7;
    final menitWib = _waktu.hour * 60 + _waktu.minute;
    final menitTujuan = menitWib + (offsetTujuan - offsetWib) * 60;

    final selisihHari = (menitTujuan / 1440).floor(); // -1, 0, atau 1
    final menitHari = menitTujuan % 1440; // selalu 0..1439
    final jam = (menitHari ~/ 60).toString().padLeft(2, '0');
    final menit = (menitHari % 60).toString().padLeft(2, '0');

    String keterangan = '';
    if (selisihHari < 0) keterangan = ' (hari sebelumnya)';
    if (selisihHari > 0) keterangan = ' (hari berikutnya)';
    return '$jam:$menit$keterangan';
  }

  @override
  Widget build(BuildContext context) {
    final jam = _waktu.hour.toString().padLeft(2, '0');
    final menit = _waktu.minute.toString().padLeft(2, '0');
    final offsetToronto = _musimPanas ? -4 : -5;

    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Waktu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Waktu input (WIB):', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _pilihWaktu,
              icon: const Icon(Icons.access_time),
              label: Text('$jam:$menit', style: const TextStyle(fontSize: 20)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Toronto musim panas (EDT, UTC-4)'),
              value: _musimPanas,
              onChanged: (v) => setState(() => _musimPanas = v),
            ),
            const Divider(height: 32),
            _HasilTile(zona: 'Indonesia (WIB, UTC+7)', waktu: _konversi(7)),
            _HasilTile(zona: 'Malaysia (UTC+8)', waktu: _konversi(8)),
            _HasilTile(
              zona: 'Kanada - Toronto (UTC$offsetToronto)',
              waktu: _konversi(offsetToronto),
            ),
          ],
        ),
      ),
    );
  }
}

class _HasilTile extends StatelessWidget {
  final String zona;
  final String waktu;

  const _HasilTile({required this.zona, required this.waktu});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(zona),
        trailing: Text(
          waktu,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
