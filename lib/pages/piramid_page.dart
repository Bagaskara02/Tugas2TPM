import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        title: const Text(
          'Luas & Volume Piramid',
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF5C6BC0),
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: const Color(0xFF5C6BC0),
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          tabs: const [
            Tab(text: 'Volume'),
            Tab(text: 'Luas Permukaan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_VolumeTab(), _LuasTab()],
      ),
    );
  }
}

// ============================================================
// VOLUME TAB
// ============================================================
class _VolumeTab extends StatefulWidget {
  const _VolumeTab();

  @override
  State<_VolumeTab> createState() => _VolumeTabState();
}

class _VolumeTabState extends State<_VolumeTab> {
  String _bentukAlas = 'persegi'; // 'persegi' or 'persegi_panjang'
  final _sisiController = TextEditingController();
  final _panjangController = TextEditingController();
  final _lebarController = TextEditingController();
  final _tinggiController = TextEditingController();

  bool _showResult = false;
  double _luasAlas = 0;
  double _volume = 0;
  List<String> _steps = [];

  void _calculate() {
    double luasAlas = 0;
    double tinggi = double.tryParse(_tinggiController.text) ?? 0;
    List<String> steps = [];

    if (_bentukAlas == 'persegi') {
      double sisi = double.tryParse(_sisiController.text) ?? 0;
      if (sisi <= 0 || tinggi <= 0) {
        _showError('Masukkan semua nilai dengan benar (> 0)');
        return;
      }
      luasAlas = sisi * sisi;
      steps.add('Langkah 1: Hitung Luas Alas (Persegi)');
      steps.add('L_alas = sisi × sisi = $sisi × $sisi = $luasAlas');
    } else {
      double panjang = double.tryParse(_panjangController.text) ?? 0;
      double lebar = double.tryParse(_lebarController.text) ?? 0;
      if (panjang <= 0 || lebar <= 0 || tinggi <= 0) {
        _showError('Masukkan semua nilai dengan benar (> 0)');
        return;
      }
      luasAlas = panjang * lebar;
      steps.add('Langkah 1: Hitung Luas Alas (Persegi Panjang)');
      steps.add('L_alas = panjang × lebar = $panjang × $lebar = $luasAlas');
    }

    double volume = (1.0 / 3.0) * luasAlas * tinggi;
    steps.add('');
    steps.add('Langkah 2: Hitung Volume Piramid');
    steps.add('V = ⅓ × L_alas × tinggi');
    steps.add('V = ⅓ × $luasAlas × $tinggi');
    steps.add('V = ${volume.toStringAsFixed(2)}');

    setState(() {
      _luasAlas = luasAlas;
      _volume = volume;
      _steps = steps;
      _showResult = true;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  @override
  void dispose() {
    _sisiController.dispose();
    _panjangController.dispose();
    _lebarController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Base shape selector
          const Text(
            'Bentuk Alas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildChip('Persegi', 'persegi'),
              const SizedBox(width: 10),
              _buildChip('Persegi Panjang', 'persegi_panjang'),
            ],
          ),
          const SizedBox(height: 18),

          // Input fields
          if (_bentukAlas == 'persegi')
            _buildInputField(
              'Sisi (s)',
              _sisiController,
              Icons.straighten_rounded,
            )
          else ...[
            _buildInputField(
              'Panjang (p)',
              _panjangController,
              Icons.straighten_rounded,
            ),
            const SizedBox(height: 12),
            _buildInputField(
              'Lebar (l)',
              _lebarController,
              Icons.straighten_rounded,
            ),
          ],
          const SizedBox(height: 12),
          _buildInputField(
            'Tinggi Piramid (t)',
            _tinggiController,
            Icons.height_rounded,
          ),
          const SizedBox(height: 20),

          // Calculate button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C6BC0),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Hitung Volume',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          // Results
          if (_showResult) ...[
            const SizedBox(height: 24),
            // Result card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5C6BC0), Color(0xFF7C4DFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'Volume Piramid',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _volume.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Luas Alas: ${_luasAlas.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Steps
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
                        Icons.menu_book_rounded,
                        size: 18,
                        color: Color(0xFF5C6BC0),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Langkah Perhitungan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ..._steps.map((step) {
                    if (step.isEmpty) {
                      return const SizedBox(height: 8);
                    }
                    final isHeader = step.startsWith('Langkah');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        step,
                        style: TextStyle(
                          fontSize: isHeader ? 13 : 14,
                          fontWeight: isHeader
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isHeader
                              ? const Color(0xFF5C6BC0)
                              : Colors.black87,
                          fontFamily: isHeader ? null : 'monospace',
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final selected = _bentukAlas == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _bentukAlas = value;
          _showResult = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF5C6BC0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF5C6BC0) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF5C6BC0), size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
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
          borderSide: const BorderSide(color: Color(0xFF5C6BC0), width: 2),
        ),
      ),
    );
  }
}

// ============================================================
// LUAS PERMUKAAN TAB
// ============================================================
class _LuasTab extends StatefulWidget {
  const _LuasTab();

  @override
  State<_LuasTab> createState() => _LuasTabState();
}

class _LuasTabState extends State<_LuasTab> {
  String _bentukAlas = 'persegi';
  final _sisiController = TextEditingController();
  final _panjangController = TextEditingController();
  final _lebarController = TextEditingController();
  final _tinggiMiringController = TextEditingController();

  bool _showResult = false;
  double _luasAlas = 0;
  double _luasTotal = 0;
  List<String> _steps = [];

  void _calculate() {
    double luasAlas = 0;
    double kelilingAlas = 0;
    double tinggiMiring = double.tryParse(_tinggiMiringController.text) ?? 0;
    List<String> steps = [];

    if (_bentukAlas == 'persegi') {
      double sisi = double.tryParse(_sisiController.text) ?? 0;
      if (sisi <= 0 || tinggiMiring <= 0) {
        _showError('Masukkan semua nilai dengan benar (> 0)');
        return;
      }
      luasAlas = sisi * sisi;
      kelilingAlas = 4 * sisi;
      steps.add('Langkah 1: Hitung Luas Alas (Persegi)');
      steps.add('L_alas = sisi × sisi = $sisi × $sisi = $luasAlas');
      steps.add('');
      steps.add('Langkah 2: Hitung Keliling Alas');
      steps.add('K_alas = 4 × sisi = 4 × $sisi = $kelilingAlas');
    } else {
      double panjang = double.tryParse(_panjangController.text) ?? 0;
      double lebar = double.tryParse(_lebarController.text) ?? 0;
      if (panjang <= 0 || lebar <= 0 || tinggiMiring <= 0) {
        _showError('Masukkan semua nilai dengan benar (> 0)');
        return;
      }
      luasAlas = panjang * lebar;
      kelilingAlas = 2 * (panjang + lebar);
      steps.add('Langkah 1: Hitung Luas Alas (Persegi Panjang)');
      steps.add('L_alas = panjang × lebar = $panjang × $lebar = $luasAlas');
      steps.add('');
      steps.add('Langkah 2: Hitung Keliling Alas');
      steps.add(
        'K_alas = 2 × (p + l) = 2 × ($panjang + $lebar) = $kelilingAlas',
      );
    }

    double luasSelimut = 0.5 * kelilingAlas * tinggiMiring;
    double luasTotal = luasAlas + luasSelimut;

    steps.add('');
    steps.add('Langkah 3: Hitung Luas Selimut');
    steps.add('L_selimut = ½ × K_alas × tinggi_miring');
    steps.add(
      'L_selimut = ½ × $kelilingAlas × $tinggiMiring = ${luasSelimut.toStringAsFixed(2)}',
    );
    steps.add('');
    steps.add('Langkah 4: Hitung Luas Permukaan Total');
    steps.add('L_total = L_alas + L_selimut');
    steps.add(
      'L_total = $luasAlas + ${luasSelimut.toStringAsFixed(2)} = ${luasTotal.toStringAsFixed(2)}',
    );

    setState(() {
      _luasAlas = luasAlas;
      _luasTotal = luasTotal;
      _steps = steps;
      _showResult = true;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  @override
  void dispose() {
    _sisiController.dispose();
    _panjangController.dispose();
    _lebarController.dispose();
    _tinggiMiringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Base shape selector
          const Text(
            'Bentuk Alas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildChip('Persegi', 'persegi'),
              const SizedBox(width: 10),
              _buildChip('Persegi Panjang', 'persegi_panjang'),
            ],
          ),
          const SizedBox(height: 18),

          // Input fields
          if (_bentukAlas == 'persegi')
            _buildInputField(
              'Sisi (s)',
              _sisiController,
              Icons.straighten_rounded,
            )
          else ...[
            _buildInputField(
              'Panjang (p)',
              _panjangController,
              Icons.straighten_rounded,
            ),
            const SizedBox(height: 12),
            _buildInputField(
              'Lebar (l)',
              _lebarController,
              Icons.straighten_rounded,
            ),
          ],
          const SizedBox(height: 12),
          _buildInputField(
            'Tinggi Miring (tm)',
            _tinggiMiringController,
            Icons.signal_cellular_alt_rounded,
          ),
          const SizedBox(height: 20),

          // Calculate button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C6BC0),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Hitung Luas Permukaan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          // Results
          if (_showResult) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'Luas Permukaan Piramid',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _luasTotal.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Luas Alas: ${_luasAlas.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Steps
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
                        Icons.menu_book_rounded,
                        size: 18,
                        color: Color(0xFF5C6BC0),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Langkah Perhitungan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ..._steps.map((step) {
                    if (step.isEmpty) {
                      return const SizedBox(height: 8);
                    }
                    final isHeader = step.startsWith('Langkah');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        step,
                        style: TextStyle(
                          fontSize: isHeader ? 13 : 14,
                          fontWeight: isHeader
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isHeader
                              ? const Color(0xFF5C6BC0)
                              : Colors.black87,
                          fontFamily: isHeader ? null : 'monospace',
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final selected = _bentukAlas == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _bentukAlas = value;
          _showResult = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF5C6BC0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF5C6BC0) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF5C6BC0), size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
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
          borderSide: const BorderSide(color: Color(0xFF5C6BC0), width: 2),
        ),
      ),
    );
  }
}
