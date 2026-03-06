import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer? _timer;
  int _elapsedMilliseconds = 0;
  bool _isRunning = false;

  void _start() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedMilliseconds += 10;
      });
    });
  }

  void _stop() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _elapsedMilliseconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime() {
    int seconds = (_elapsedMilliseconds ~/ 1000) % 60;
    int minutes = (_elapsedMilliseconds ~/ 60000) % 60;
    int hours = _elapsedMilliseconds ~/ 3600000;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _formatCentiseconds() {
    int hundreds = (_elapsedMilliseconds ~/ 10) % 100;
    return '.${hundreds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatTime(),
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF00695C),
                      letterSpacing: 3,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _formatCentiseconds(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00695C),
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Reset and Start buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Reset button
                  SizedBox(
                    width: 120,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Start button
                  SizedBox(
                    width: 120,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: _isRunning ? null : _start,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Stop button
              SizedBox(
                width: 260,
                height: 44,
                child: OutlinedButton(
                  onPressed: _isRunning ? _stop : null,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: _isRunning ? Colors.red : Colors.red.shade200,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    'Stop',
                    style: TextStyle(
                      color: _isRunning ? Colors.red : Colors.red.shade200,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
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
