import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

// Widget Kalkulator untuk mengoperasikan penjumlahan dan pengurangan
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller untuk membaca nilai input dari TextField
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Variabel untuk menyimpan pesan hasil perhitungan sebagai String
  String _result = '0';

  // Fungsi untuk menghapus input
  void _clearInputs() {
    _num1Controller.clear();
    _num2Controller.clear();
    setState(() {
      _result = '0';
    });
  }

  // Fungsi validasi input
  bool _validateInputs() {
    String text1 = _num1Controller.text.trim();
    String text2 = _num2Controller.text.trim();

    if (text1.isEmpty || text2.isEmpty) {
      _showErrorDialog('Input Kosong', 'Harap masukkan kedua angka terlebih dahulu!');
      return false;
    }

    if (double.tryParse(text1) == null || double.tryParse(text2) == null) {
      _showErrorDialog('Input Tidak Valid', 'Harap masukkan angka yang valid!');
      return false;
    }

    double num1 = double.parse(text1);
    double num2 = double.parse(text2);

    // Validasi nilai angka (tidak terlalu besar atau terlalu kecil)
    if (num1.isInfinite || num1.isNaN || num2.isInfinite || num2.isNaN) {
      _showErrorDialog('Angka Tidak Valid', 'Harap masukkan angka yang valid (tidak infinite atau NaN)!');
      return false;
    }

    return true;
  }

  // Fungsi untuk menampilkan dialog error
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: Colors.red)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Fungsi Penjumlahan (+)
  void _add() {
    // Validasi input
    if (!_validateInputs()) return;

    // Mengekstraksi angka dari TextField
    double num1 = double.parse(_num1Controller.text.trim());
    double num2 = double.parse(_num2Controller.text.trim());
    
    try {
      setState(() {
        // Menyimpan hasil pertambahan
        double res = num1 + num2;
        
        // Format hasil: jika bulat, tampilkan tanpa desimal, jika tidak tampilkan dengan desimal
        if (res % 1 == 0) {
          // Cek apakah angka bisa di-convert ke int tanpa overflow
          if (res.isInfinite || res > 9223372036854775807 || res < -9223372036854775807) {
            _result = res.toStringAsFixed(2); // Format dengan 2 desimal untuk angka sangat besar
          } else {
            _result = res.toInt().toString();
          }
        } else {
          // Format dengan maksimal 10 desimal untuk angka dengan koma
          _result = res.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      });
    } catch (e) {
      _showErrorDialog('Overflow Error', 'Hasil perhitungan terlalu besar untuk ditampilkan!');
    }
  }

  // Fungsi Pengurangan (-)
  void _subtract() {
    // Validasi input
    if (!_validateInputs()) return;

    // Mengekstraksi angka dari TextField
    double num1 = double.parse(_num1Controller.text.trim());
    double num2 = double.parse(_num2Controller.text.trim());

    try {
      setState(() {
        // Menyimpan hasil pengurangan
        double res = num1 - num2;
        
        // Format hasil: jika bulat, tampilkan tanpa desimal, jika tidak tampilkan dengan desimal
        if (res % 1 == 0) {
          // Cek apakah angka bisa di-convert ke int tanpa overflow
          if (res.isInfinite || res > 9223372036854775807 || res < -9223372036854775807) {
            _result = res.toStringAsFixed(2); // Format dengan 2 desimal untuk angka sangat besar
          } else {
            _result = res.toInt().toString();
          }
        } else {
          // Format dengan maksimal 10 desimal untuk angka dengan koma
          _result = res.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      });
    } catch (e) {
      _showErrorDialog('Overflow Error', 'Hasil perhitungan terlalu besar untuk ditampilkan!');
    }
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana', style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Dekoratif melengkung
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 20),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Text(
                'Masukkan dua angka di bawah untuk\nmenjumlahkan atau mengurangkan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),
            
            // Konten mengapung di atas header
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Card Input
                    Container(
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
                        children: [
                          // Input Angka Pertama
                          TextField(
                            controller: _num1Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Angka Pertama',
                              labelStyle: const TextStyle(color: AppColors.primaryColor),
                              prefixIcon: const Icon(Icons.looks_one, color: AppColors.primaryColor),
                              filled: true,
                              fillColor: AppColors.backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Input Angka Kedua
                          TextField(
                            controller: _num2Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Angka Kedua',
                              labelStyle: const TextStyle(color: AppColors.primaryColor),
                              prefixIcon: const Icon(Icons.looks_two, color: AppColors.primaryColor),
                              filled: true,
                              fillColor: AppColors.backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Baris Tombol Operasi
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _add,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.secondaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 4,
                              shadowColor: AppColors.primaryColor.withAlpha(102),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('+', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _subtract,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.secondaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 4,
                              shadowColor: AppColors.primaryColor.withAlpha(102),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('-', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    // Tombol Clear (Lebar Penuh)
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: _clearInputs,
                        icon: const Icon(Icons.refresh, color: Colors.black54),
                        label: const Text(
                          'Reset Input',
                          style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.grey.withAlpha(26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Card Hasil
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withAlpha(204),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withAlpha(77),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'HA S I L',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _result,
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
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
