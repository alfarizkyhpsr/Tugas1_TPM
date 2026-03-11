import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PyramidCalculatorScreen extends StatefulWidget {
  const PyramidCalculatorScreen({super.key});

  @override
  State<PyramidCalculatorScreen> createState() => _PyramidCalculatorScreenState();
}

class _PyramidCalculatorScreenState extends State<PyramidCalculatorScreen> {
  final TextEditingController _sideController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  
  String _surfaceAreaResult = '-';
  String _volumeResult = '-';
  String? _errorMessage;

  void _calculate() {
    final sideStr = _sideController.text.trim();
    final heightStr = _heightController.text.trim();

    setState(() {
      _errorMessage = null;
      
      if (sideStr.isEmpty || heightStr.isEmpty) {
        _errorMessage = 'Sisi alas dan tinggi tidak boleh kosong!';
        _surfaceAreaResult = '-';
        _volumeResult = '-';
        return;
      }

      final side = double.tryParse(sideStr);
      final height = double.tryParse(heightStr);

      if (side == null || height == null) {
        _errorMessage = 'Masukkan angka yang valid!';
        _surfaceAreaResult = '-';
        _volumeResult = '-';
        return;
      }

      if (side <= 0 || height <= 0) {
        _errorMessage = 'Nilai harus lebih besar dari 0!';
        _surfaceAreaResult = '-';
        _volumeResult = '-';
        return;
      }

      // Rumus Piramid (Limas Segiempat Sama Sisi)
      // Luas Alas = s * s
      double baseArea = side * side;
      
      // Volume = 1/3 * Luas Alas * Tinggi
      double volume = (1 / 3) * baseArea * height;
      
      // Luas Permukaan = Luas Alas + (4 * Luas Segitiga Selimut)
      // Tinggi Segitiga (slant height) = sqrt((s/2)^2 + t^2)
      double slantHeight = sqrt(pow(side / 2, 2) + pow(height, 2));
      double triangleArea = 0.5 * side * slantHeight;
      double surfaceArea = baseArea + (4 * triangleArea);

      _volumeResult = volume.toStringAsFixed(2);
      _surfaceAreaResult = surfaceArea.toStringAsFixed(2);
    });
  }

  void _clear() {
    setState(() {
      _sideController.clear();
      _heightController.clear();
      _surfaceAreaResult = '-';
      _volumeResult = '-';
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _sideController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Kalkulator Piramid', 
          style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold)
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header melengkung
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 50, top: 20),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Text(
                'Hitung Luas Permukaan dan Volume\nPiramid (Limas Segiempat) dengan mudah.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),

            // Card Input
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(13),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildInputField(
                            controller: _sideController,
                            label: 'Sisi Alas',
                            icon: Icons.square_foot,
                          ),
                          const SizedBox(height: 16),
                          _buildInputField(
                            controller: _heightController,
                            label: 'Tinggi',
                            icon: Icons.height,
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(26),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(_errorMessage!, 
                                      style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: _calculate,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 4,
                                    shadowColor: AppColors.primaryColor.withAlpha(102),
                                  ),
                                  child: const Text('Hitung Sekarang', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _clear,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.withAlpha(51),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: const Icon(Icons.refresh),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Card Hasil
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryColor, AppColors.primaryColor.withAlpha(204)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
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
                          _buildResultRow(
                            label: 'L. Permukaan',
                            value: _surfaceAreaResult,
                            unit: 'cm²',
                            icon: Icons.layers_outlined,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: Colors.white24, height: 1),
                          ),
                          _buildResultRow(
                            label: 'Volume',
                            value: _volumeResult,
                            unit: 'cm³',
                            icon: Icons.view_in_ar_rounded,
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        filled: true,
        fillColor: AppColors.backgroundColor.withAlpha(128),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _buildResultRow({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
  }) {
    return Row(
      children: [
        // Bagian Label di Kiri
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label, 
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Bagian Hasil di Kanan (Mencegah Overflow)
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value, 
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit, 
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
