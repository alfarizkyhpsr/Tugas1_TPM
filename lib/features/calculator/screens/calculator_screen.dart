import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

// Widget Kalkulator untuk mengoperasikan penjumlahan dan pengurangan
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller untuk membaca nilai input dari TextField
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Variabel untuk menyimpan pesan hasil perhitungan sebagai String
  String _result = '0';

  // Fungsi Penjumlahan (+)
  void _add() {
    // Mengekstraksi angka dari TextField, defaultnya 0 jika kosong atau tidak valid
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;
    
    // setState() akan membangun ulang (rebuild) layar 
    // agar layar dapat menampilkan hasil terbaru
    setState(() {
      // Menyimpan hasil pertambahan. Menghapus koma jika angkanya bulat
      double res = num1 + num2;
      _result = (res % 1 == 0) ? res.toInt().toString() : res.toString();
    });
  }

  // Fungsi Pengurangan (-)
  void _subtract() {
    // Mengekstraksi angka dari TextField, defaultnya 0 jika kosong atau tidak valid
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;

    // setState() akan memperbarui UI dengan hasil terbaru
    setState(() {
      // Menyimpan hasil pengurangan
      double res = num1 - num2;
      _result = (res % 1 == 0) ? res.toInt().toString() : res.toString();
    });
  }

  @override
  void dispose() {
    // Selalu buang (dispose) controller saat keluar dari layar
    // untuk mencegah kebocoran memori (memory leak)
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana', style: TextStyle(color: AppColors.secondaryColor)),
        backgroundColor: AppColors.primaryColor, // Biru Laut
        iconTheme: const IconThemeData(color: AppColors.secondaryColor), // Panah kembali berwarna putih
      ),
      backgroundColor: AppColors.secondaryColor, // Latar belakang dominan warna kedua (Putih)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Label Penjelasan
            const Text(
              'Masukkan dua angka di bawah untuk menjumlahkan atau mengurangkan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 30),

            // Input Angka Pertama
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number, // Memastikan keyboard Android/iOS berupa angka
              decoration: InputDecoration(
                labelText: 'Angka Pertama',
                labelStyle: const TextStyle(color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Angka Kedua
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number, // Keyboard format nomor
              decoration: InputDecoration(
                labelText: 'Angka Kedua',
                labelStyle: const TextStyle(color: AppColors.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Baris Tombol Operasi Utama (Tambah & Kurang)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol Penjumlahan
                ElevatedButton(
                  onPressed: _add, // Panggil fungsi penjumlahan saat diklik
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Background biru laut
                    foregroundColor: AppColors.secondaryColor, // Teks warna putih
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('+', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
                
                // Tombol Pengurangan
                ElevatedButton(
                  onPressed: _subtract, // Panggil fungsi pengurangan saat diklik
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Background biru laut
                    foregroundColor: AppColors.secondaryColor, // Teks warna putih
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('-', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Penampil Teks Hasil
            const Text(
              'Hasil:',
              style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 10),
            
            // Angka Output
            Text(
              _result,
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor, // Menampilkan warna utama untuk hasil
              ),
            ),
          ],
        ),
      ),
    );
  }
}
