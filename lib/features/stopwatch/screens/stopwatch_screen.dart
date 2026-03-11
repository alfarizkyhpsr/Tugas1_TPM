import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  final List<String> _laps = [];

  void _startStopwatch() {
    setState(() {
      _stopwatch.start();
    });
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  void _stopStopwatch() {
    setState(() {
      _stopwatch.stop();
    });
    _timer.cancel();
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _laps.clear();
    });
    if (_timer.isActive) _timer.cancel();
  }

  void _addLap() {
    setState(() {
      _laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    if (hours > 0) {
      return "$hoursStr:$minutesStr:$secondsStr.$hundredsStr";
    }
    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  void dispose() {
    if (_stopwatch.isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Stopwatch', style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: Column(
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
              'Gunakan stopwatch ini untuk\nmenghitung durasi dengan akurat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
          ),
          
          // Konten Timer mengapung di atas header
          Transform.translate(
            offset: const Offset(0, -20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                  border: Border.all(
                    color: AppColors.primaryColor.withAlpha(26),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatTime(_stopwatch.elapsedMilliseconds),
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Courier', // Monospaced font for steady text
                          color: AppColors.primaryColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Daftar Lap
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryColor.withAlpha(26)),
              ),
              child: _laps.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.flag_outlined, size: 48, color: Colors.grey.withAlpha(100)),
                          const SizedBox(height: 16),
                          const Text(
                            'Belum ada catatan waktu',
                            style: TextStyle(color: Colors.black45, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _laps.length,
                      separatorBuilder: (context, index) => const Divider(height: 24),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withAlpha(26),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${_laps.length - index}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Lap Time',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _laps[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Courier',
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          
          // Bagian Tombol Kontrol
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  onPressed: _stopwatch.isRunning || _stopwatch.elapsedMilliseconds == 0 ? null : _resetStopwatch,
                  icon: Icons.refresh,
                  label: 'Reset',
                  backgroundColor: AppColors.backgroundColor,
                  iconColor: Colors.black54,
                ),
                _buildMainActionButton(
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                  icon: _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                  isDestructive: _stopwatch.isRunning,
                ),
                _buildActionButton(
                  onPressed: _stopwatch.isRunning ? _addLap : null,
                  icon: Icons.flag,
                  label: 'Lap',
                  backgroundColor: Colors.blue.withAlpha(26),
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tombol aksi sekunder (Reset / Lap)
  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: onPressed == null ? Colors.grey.withAlpha(26) : backgroundColor,
            ),
            child: Icon(
              icon,
              color: onPressed == null ? Colors.grey : iconColor,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: onPressed == null ? Colors.grey : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // Tombol aksi utama (Start / Pause)
  Widget _buildMainActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required bool isDestructive,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (isDestructive ? Colors.orange : AppColors.primaryColor).withAlpha(77),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
          backgroundColor: isDestructive ? Colors.orange : AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        child: Icon(icon, size: 36),
      ),
    );
  }
}
