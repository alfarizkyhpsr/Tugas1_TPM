import 'package:flutter/material.dart';
import '../../calculator/screens/calculator_screen.dart';
import '../../auth/screens/login_screen.dart';
import '../../../core/constants/app_colors.dart';

// Layar utama (Dashboard) yang menyediakan navigasi ke fitur aplikasi lainnya
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Fungsi log out untuk kembali ke halaman login
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Warna latar abu-abu terang
      appBar: AppBar(
        title: const Text('Menu Utama', style: TextStyle(color: AppColors.secondaryColor)),
        backgroundColor: AppColors.primaryColor, // AppBar dengan warna biru laut
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        actions: [
          // Tombol Keluar (Logout) di bagian kanan atas AppBar
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.secondaryColor),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Menu: Bagian Menampilkan Data Kelompok Project
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.secondaryColor, // Kartu berwarna putih
              elevation: 4, // Memberikan efek bayangan pada kartu
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                      'Data Kelompok',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Divider(), // Garis pemisah
                    // Silakan ganti nama-nama di bawah dengan anggota kelompok Anda
                    Text('1. R ANDHIKA DANENDRA PRASETYA (123230008)', style: TextStyle(fontSize: 16)),
                    Text('2. HAFIDZ AL FATHIN NASRULLAH (123230207)', style: TextStyle(fontSize: 16)),
                    Text('3. RAFLY ANDHIKA DEWANDARU (123230202)', style: TextStyle(fontSize: 16)),
                    Text('4. ALFA RIZKY HAPSORI (123230222)', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Menuju Menu Penjumlahan dan Pengurangan
            ElevatedButton(
              onPressed: () {
                // Berpindah ke Kalkulator Penjumlahan dan Pengurangan saat ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculatorScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Latar tombol biru laut
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Menu Kalkulator (+ dan -)',
                style: TextStyle(fontSize: 18, color: AppColors.secondaryColor), // Teks putih
              ),
            ),
            
            // Catatan: Menu Ganjil/Genap, Prima, Total Angka, Stopwatch, dsb. 
            // dapat ditambahkan di bawah ini jika ingin dikerjakan nanti.
          ],
        ),
      ),
    );
  }
}
