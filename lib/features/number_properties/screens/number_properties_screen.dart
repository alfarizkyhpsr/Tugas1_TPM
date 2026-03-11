import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

// Widget untuk mengecek apakah bilangan termasuk ganjil/genap dan bilangan prima
class NumberPropertiesScreen extends StatefulWidget {
  const NumberPropertiesScreen({super.key});

  @override
  State<NumberPropertiesScreen> createState() => _NumberPropertiesScreenState();
}

class _NumberPropertiesScreenState extends State<NumberPropertiesScreen> {
  // Controller untuk membaca nilai input dari TextField
  final TextEditingController _numberController = TextEditingController();

  // Variabel untuk menyimpan hasil analisis bilangan
  String _resultText = 'Masukkan bilangan untuk dianalisis';
  String _isOddEven = '';
  String _isPrime = '';
  bool _hasAnalyzed = false;

  // Fungsi untuk mengecek apakah bilangan termasuk bilangan prima
  bool _isPrimeNumber(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

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

  // Fungsi untuk menganalisis bilangan ketika tombol ditekan
  void _analyzeNumber() {
    String input = _numberController.text.trim();

    if (input.isEmpty) {
      _showErrorDialog('Input Kosong', 'Harap masukkan bilangan terlebih dahulu!');
      setState(() {
        _hasAnalyzed = false;
        _resultText = 'Input kosong!';
      });
      return;
    }

    int? number = int.tryParse(input);
    if (number == null) {
      _showErrorDialog('Input Tidak Valid', 'Input harus berupa bilangan bulat tanpa desimal!');
      setState(() {
        _hasAnalyzed = false;
        _resultText = 'Input tidak valid!';
      });
      return;
    }

    String oddEven = (number % 2 == 0) ? 'Genap' : 'Ganjil';
    bool prime = _isPrimeNumber(number);

    setState(() {
      _hasAnalyzed = true;
      _resultText = 'Hasil Analisis Angka $number';
      _isOddEven = oddEven;
      _isPrime = prime ? 'Bilangan Prima' : 'Bukan Prima';
    });
  }

  // Fungsi untuk menghapus input
  void _clearInput() {
    _numberController.clear();
    setState(() {
      _hasAnalyzed = false;
      _resultText = 'Masukkan bilangan untuk dianalisis';
      _isOddEven = '';
      _isPrime = '';
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Analisis Bilangan', style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600)),
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
                'Cek apakah sebuah angka termasuk\nGanjil / Genap dan Bilangan Prima.',
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
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Masukkan Bilangan',
                              labelStyle: const TextStyle(color: AppColors.primaryColor),
                              hintText: 'Contoh: 17',
                              prefixIcon: const Icon(Icons.numbers, color: AppColors.primaryColor),
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

                          // Tombol Analisis dan Hapus
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _analyzeNumber,
                                  icon: const Icon(Icons.analytics_outlined),
                                  label: const Text(
                                    'Analisis',
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
                    if (_hasAnalyzed)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryColor.withAlpha(51),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _resultText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 20),
                            
                            // Baris Sifat 1: Ganjil / Genap
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withAlpha(26),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.pie_chart_outline, color: AppColors.primaryColor),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Sifat Bilangan',
                                        style: TextStyle(fontSize: 12, color: Colors.black54),
                                      ),
                                      Text(
                                        _isOddEven,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Baris Sifat 2: Prima / Bukan
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: _isPrime == 'Bilangan Prima'
                                          ? Colors.green.withAlpha(26)
                                          : Colors.orange.withAlpha(26),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isPrime == 'Bilangan Prima' ? Icons.check_circle_outline : Icons.cancel_outlined,
                                      color: _isPrime == 'Bilangan Prima' ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Status Prima',
                                        style: TextStyle(fontSize: 12, color: Colors.black54),
                                      ),
                                      Text(
                                        _isPrime,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: _isPrime == 'Bilangan Prima' ? Colors.green[700] : Colors.orange[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
