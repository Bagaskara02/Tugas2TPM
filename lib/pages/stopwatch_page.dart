import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  final int _startMilliseconds = 0;

  late int _elapsedMilliseconds = _startMilliseconds;
  
  final List<_LapData> _laps = [];

  bool get _isRunning => _stopwatch.isRunning;

  void _start() {
    if (_isRunning) return;
    
    _stopwatch.start();
    
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedMilliseconds = _startMilliseconds + _stopwatch.elapsedMilliseconds;
      });
    });
  }

  void _stop() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _reset() {
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    
    setState(() {
      _elapsedMilliseconds = _startMilliseconds; 
      _laps.clear();
    });
  }

  void _lap() {
    if (!_isRunning) return;
    
    final prevTotal = _laps.isEmpty ? _startMilliseconds : _laps.last.totalMs;

    final lapMs = _elapsedMilliseconds - prevTotal;
    
    setState(() {
      _laps.add(
        _LapData(
          lapNumber: _laps.length + 1,
          lapMs: lapMs,
          totalMs: _elapsedMilliseconds,
        ),
      );
    });
  }

  String _formatMs(int ms) {
    int seconds = (ms ~/ 1000) % 60;
    int minutes = (ms ~/ 60000) % 60;
    int hours = ms ~/ 3600000;
    
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _formatCenti(int ms) {
    int hundreds = (ms ~/ 10) % 100;
    return '.${hundreds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
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
      body: Column(
        children: [
          const SizedBox(height: 32),
          // Timer display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatMs(_elapsedMilliseconds),
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
                  _formatCenti(_elapsedMilliseconds),
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
          const SizedBox(height: 36),

          // Buttons row: Reset | Lap | Start/Stop
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reset button
                SizedBox(
                  width: 90,
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
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Lap button
                SizedBox(
                  width: 90,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: _isRunning ? _lap : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _isRunning
                            ? const Color(0xFF5C6BC0)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      'Lap',
                      style: TextStyle(
                        color: _isRunning
                            ? const Color(0xFF5C6BC0)
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Start/Stop button
                SizedBox(
                  width: 100,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: _isRunning ? _stop : _start,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _isRunning ? Colors.red : Colors.green,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      _isRunning ? 'Stop' : 'Start',
                      style: TextStyle(
                        color: _isRunning ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Lap list
          if (_laps.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Text(
                    'Laps',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_laps.length} lap${_laps.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(height: 1, color: Colors.grey.shade200),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8,
                ),
                itemCount: _laps.length,
                itemBuilder: (context, index) {
                  // Show latest lap first
                  final lap = _laps[_laps.length - 1 - index];
                  Color lapColor = Colors.black87;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Lap number
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${lap.lapNumber}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: lapColor,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Lap time
                        Expanded(
                          child: Text(
                            '${_formatMs(lap.lapMs)}${_formatCenti(lap.lapMs)}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: lapColor,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ),
                        // Total time
                        Text(
                          '${_formatMs(lap.totalMs)}${_formatCenti(lap.totalMs)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else
            const Spacer(),
        ],
      ),
    );
  }
}

class _LapData {
  final int lapNumber;
  final int lapMs;
  final int totalMs;

  _LapData({
    required this.lapNumber,
    required this.lapMs,
    required this.totalMs,
  });
}