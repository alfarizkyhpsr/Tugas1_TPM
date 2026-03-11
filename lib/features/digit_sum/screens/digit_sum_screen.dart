import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

// Widget untuk menghitung jumlah total angka-angka dalam suatu input list angka
class DigitSumScreen extends StatefulWidget {
  const DigitSumScreen({super.key});

  @override
  State<DigitSumScreen> createState() => _DigitSumScreenState();
}

class _DigitSumScreenState extends State<DigitSumScreen> {
  // Controller untuk membaca nilai input dari TextField
  final TextEditingController _numbersController = TextEditingController();

  // Variabel untuk menyimpan hasil perhitungan
  String _resultText = 'Masukkan daftar angka untuk dihitung totalnya';
  int _totalSum = 0;
  int _countNumbers = 0;
  bool _hasError = false;

  // Fungsi untuk menampilkan error dialog
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

  // Fungsi untuk menghitung jumlah total dari daftar angka
  void _calculateSum() {
    String input = _numbersController.text.trim();

    if (input.isEmpty) {
      _showErrorDialog('Input Kosong', 'Harap masukkan daftar angka terlebih dahulu!');
      setState(() {
        _resultText = 'Input kosong!';
        _totalSum = 0;
        _countNumbers = 0;
        _hasError = true;
      });
      return;
    }

    input = input.trim();
    List<String> parts = input.split(RegExp(r'[,\s]+'));
    parts = parts.where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) {
      _showErrorDialog('Input Tidak Valid', 'Tidak ada angka yang ditemukan dalam input!\nGunakan format: 5, 10, 15 atau 5 10 15');
      setState(() {
        _resultText = 'Tidak ada angka yang valid.';
        _totalSum = 0;
        _countNumbers = 0;
        _hasError = true;
      });
      return;
    }

    List<int> numbers = [];
    List<String> invalidParts = [];

    for (String part in parts) {
      int? number = int.tryParse(part);
      if (number != null) {
        numbers.add(number);
      } else {
        invalidParts.add(part);
      }
    }

    if (invalidParts.isNotEmpty && numbers.isEmpty) {
      _showErrorDialog('Format Tidak Valid', 'Input harus berupa angka!\nContoh yang benar: 5, 10, 15 atau 5 10 15');
      setState(() {
        _resultText = 'Input berisi karakter tidak valid.';
        _totalSum = 0;
        _countNumbers = 0;
        _hasError = true;
      });
      return;
    }

    int sum = 0;
    for (int number in numbers) {
      sum += number;
    }

    int count = numbers.length;

    setState(() {
      _resultText = 'Berhasil Menghitung Total Angka';
      _totalSum = sum;
      _countNumbers = count;
      _hasError = false;
    });
  }

  // Fungsi untuk menghapus hasil dan input
  void _clearInput() {
    _numbersController.clear();
    setState(() {
      _resultText = 'Masukkan daftar angka untuk dihitung totalnya';
      _totalSum = 0;
      _countNumbers = 0;
      _hasError = false;
    });
  }

  @override
  void dispose() {
    _numbersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Total Angka', style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
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
                'Masukkan daftar angka yang dipisahkan\ndengan koma atau spasi.',
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
                          TextField(
                            controller: _numbersController,
                            keyboardType: TextInputType.number,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Daftar Angka',
                              alignLabelWithHint: true,
                              labelStyle: const TextStyle(color: AppColors.primaryColor),
                              hintText: 'Contoh: 5, 10, 15, 20\natau: 5 10 15 20',
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
                          const SizedBox(height: 24),

                          // Baris Tombol Eksekusi
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _calculateSum,
                                  icon: const Icon(Icons.calculate),
                                  label: const Text(
                                    'Hitung',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
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
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _clearInput,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.withAlpha(51),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Icon(Icons.refresh),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Card Hasil
                    if (_countNumbers > 0 || _hasError)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _hasError ? Colors.red.withAlpha(128) : AppColors.primaryColor.withAlpha(51),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _resultText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _hasError ? Colors.red : AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (!_hasError) ...[
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Jumlah Angka:',
                                    style: TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '$_countNumbers',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Keseluruhan:',
                                    style: TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withAlpha(26),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '$_totalSum',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
