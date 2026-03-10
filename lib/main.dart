import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'features/auth/screens/login_screen.dart';

// Fungsi utama (main root) yang menjalankan aplikasi dari awal
void main() {
  runApp(const MyApp());
}

// Widget utama yang membungkus keseluruhan struktur material aplikasi (MaterialApp)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan logo/banner 'debug' merah di pojok kanan atas aplikasi
      debugShowCheckedModeBanner: false, 
      
      title: 'Aplikasi Tugas',
      
      // Tema umum aplikasi
      theme: ThemeData(
        // Menyetel warna primer bawaan aplikasi (Biru Laut)
        primaryColor: AppColors.primaryColor,
        // Menyediakan skema warna seragam (agar elemen bawaan ikut menyesuaikan warna dasar)
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        // Menggunakan desain UI Material 3 terbaru
        useMaterial3: true,
      ),
      
      // Layar pertama yang dimuat saat aplikasi pertama kali dibuka
      home: const LoginScreen(),
    );
  }
}
