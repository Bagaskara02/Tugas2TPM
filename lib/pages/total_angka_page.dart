import 'package:flutter/material.dart';

class TotalAngkaPage extends StatefulWidget {
  const TotalAngkaPage({super.key});

  @override
  State<TotalAngkaPage> createState() => _TotalAngkaPageState();
}

class _TotalAngkaPageState extends State<TotalAngkaPage>
    with SingleTickerProviderStateMixin {
  final _inputController = TextEditingController();
  bool _showResult = false;
  List<int> _digits = [];
  int _total = 0;
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _calculate() {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Masukkan angka terlebih dahulu'),
          backgroundColor: Colors.red.shade400,
        ),
      );
      return;
    }

    // Validasi input: hanya boleh memuat angka dan tanda (, . ;)
    if (!RegExp(r'^[0-9,.;]+$').hasMatch(text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Hanya diperbolehkan angka dan pemisah (, . ;)'),
          backgroundColor: Colors.red.shade400,
        ),
      );
      return;
    }

    // Extract numbers from input (separated by allowed characters)
    final matches = RegExp(r'\d+').allMatches(text);
    final digits = matches.map((m) => int.parse(m.group(0)!)).toList();

    if (digits.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Input tidak mengandung angka'),
          backgroundColor: Colors.red.shade400,
        ),
      );
      return;
    }

    final total = digits.fold(0, (sum, d) => sum + d);

    setState(() {
      _digits = digits;
      _total = total;
      _showResult = true;
    });

    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        title: const Text(
          'Total Angka',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header explanation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Penjumlahan Angka',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Masukkan deret angka, dan lihat bagaimana setiap angka dijumlahkan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Input
            const Text(
              'Masukkan Angka',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
              decoration: InputDecoration(
                hintText: '10,20.500;30',
                hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                ),
                prefixIcon: const Icon(
                  Icons.tag_rounded,
                  color: Color(0xFF5C6BC0),
                  size: 22,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFF5C6BC0),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Calculate button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate_rounded, size: 20),
                label: const Text(
                  'Hitung Total Angka',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C6BC0),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            // Results
            if (_showResult) ...[
              const SizedBox(height: 28),

              // Digit bubbles
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _animation.value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Angka yang ditemukan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bubble wrap
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(_digits.length, (index) {
                        const color = Color(0xFF5C6BC0);
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 300 + (index * 80)),
                          curve: Curves.easeOutBack,
                          builder: (context, value, child) {
                            return Transform.scale(scale: value, child: child);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 52,
                            constraints: const BoxConstraints(minWidth: 52),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: color.withValues(alpha: 0.4),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${_digits[index]}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Step by step
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.functions_rounded,
                                size: 18,
                                color: Color(0xFF5C6BC0),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Proses Penjumlahan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Show the addition
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'monospace',
                                color: Colors.black87,
                              ),
                              children: List.generate(_digits.length * 2 - 1, (
                                i,
                              ) {
                                if (i.isEven) {
                                  final dIdx = i ~/ 2;
                                  return TextSpan(
                                    text: '${_digits[dIdx]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF5C6BC0),
                                    ),
                                  );
                                } else {
                                  return const TextSpan(
                                    text: ' + ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(height: 2, color: Colors.grey.shade200),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                '= ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'monospace',
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '$_total',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5C6BC0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Big result card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF43e97b,
                            ).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total dari ${_digits.length} angka',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_total',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
