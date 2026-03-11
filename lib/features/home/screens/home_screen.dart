import 'package:flutter/material.dart';
import '../../calculator/screens/calculator_screen.dart';
import '../../auth/screens/login_screen.dart';
import '../../number_properties/screens/number_properties_screen.dart';
import '../../digit_sum/screens/digit_sum_screen.dart';
import '../../stopwatch/screens/stopwatch_screen.dart';
import '../../pyramid/screens/pyramid_calculator_screen.dart';
import '../../../core/constants/app_colors.dart';

// Layar utama (Dashboard) yang menyediakan navigasi ke fitur aplikasi lainnya
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Menu Utama', 
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          )
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.secondaryColor),
            tooltip: 'Keluar',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section dengan background warna primer (melengkung di bawah)
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 20),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Halo,',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tugas 1 TPM',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Menggeser konten ke atas agar menimpa bagian header biru
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Card Data Kelompok
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(13),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.group, color: AppColors.primaryColor),
                              SizedBox(width: 12),
                              Text(
                                'Data Kelompok',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Divider(),
                          ),
                          const _MemberTile(name: 'R ANDHIKA DANENDRA P.', nim: '123230008'),
                          const _MemberTile(name: 'HAFIDZ AL FATHIN N.', nim: '123230207'),
                          const _MemberTile(name: 'RAFLY ANDHIKA DEWANDARU', nim: '123230202'),
                          const _MemberTile(name: 'ALFA RIZKY HAPSORI', nim: '123230222', isLast: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Label Menu
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pilihan Menu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Menu List
                    _MenuCard(
                      title: 'Kalkulator (+ dan -)',
                      icon: Icons.calculate_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CalculatorScreen()),
                        );
                      },
                    ),
                    
                    _MenuCard(
                      title: 'Analisis Bilangan',
                      icon: Icons.numbers,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NumberPropertiesScreen()),
                        );
                      },
                    ),
                    
                    _MenuCard(
                      title: 'Total Angka dalam List',
                      icon: Icons.add_circle_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DigitSumScreen()),
                        );
                      },
                    ),

                    _MenuCard(
                      title: 'Stopwatch',
                      icon: Icons.timer_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StopwatchScreen()),
                        );
                      },
                    ),

                    _MenuCard(
                      title: 'Kalkulator Piramid',
                      icon: Icons.view_in_ar_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PyramidCalculatorScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk menampilkan data anggota kelompok
class _MemberTile extends StatelessWidget {
  final String name;
  final String nim;
  final bool isLast;

  const _MemberTile({
    required this.name,
    required this.nim,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  nim,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget kecil untuk membangun Card Menu Utama secara efisien
class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primaryColor, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
