import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';
import '../../../core/constants/app_colors.dart';

// LoginScreen adalah widget StatefulWidget karena kita membutuhkan state
// untuk mengelola input teks dan menyembunyikan/menampilkan password
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller untuk membaca inputan dari TextField username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk menyimpan pesan error jika login gagal
  String _errorMessage = '';

  // Fungsi yang dipanggil ketika tombol login ditekan
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Logika sederhana: Cek mencocokkan username dan password
    // Sesuai permintaan: username = tugas1, password = 6
    if (username == 'tugas1' && password == '6') {
      // Jika berhasil login, pindah ke layar Home
      // Menggunakan pushReplacement agar user tidak bisa kembali ke halaman login 
      // jika menekan tombol 'Back' di handphone
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika salah, tampilkan pesan error dengan mengubah state
      setState(() {
        _errorMessage = 'Username atau password salah!';
      });
    }
  }

  @override
  void dispose() {
    // Membebaskan memori controller saat form login ditutup/tidak lagi digunakan
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold memberikan kerangka dasar tampilan seperti AppBar dan body
    return Scaffold(
      backgroundColor: AppColors.secondaryColor, // Latar belakang putih
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon gembok besar di atas halaman login
              const Icon(
                Icons.lock_outline,
                size: 100,
                color: AppColors.primaryColor, // Ikon biru laut
              ),
              const SizedBox(height: 30),
              
              const Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor, // Teks biru laut
                ),
              ),
              const SizedBox(height: 40),

              // Input Username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor),
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

              // Input Password
              TextField(
                controller: _passwordController,
                obscureText: true, // Menyembunyikan teks ketikan dengan titik-titik
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: AppColors.primaryColor),
                  prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Menampilkan pesan error jika form kosong saat login ditekan
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),

              // Tombol Login
              SizedBox(
                width: double.infinity, // Membuat tombol memenuhi selebar layar
                height: 50,
                child: ElevatedButton(
                  onPressed: _login, // Memanggil fungsi login saat ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Background tombol biru laut
                    foregroundColor: AppColors.secondaryColor, // Teks tombol putih
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
