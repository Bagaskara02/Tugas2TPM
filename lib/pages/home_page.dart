import 'package:flutter/material.dart';
import 'login_page.dart';
import 'stopwatch_page.dart';
import 'data_kelompok_page.dart';
import 'piramid_page.dart';
import 'total_angka_page.dart';

class HomePage extends StatelessWidget {
  final String nama;
  const HomePage({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Calculate App',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C6BC0),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Color(0xFF5C6BC0),
                      size: 24,
                    ),
                    tooltip: 'Logout',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Menu grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.95,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.groups_rounded,
                      label: 'Data Kelompok',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DataKelompokPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.calculate_rounded,
                      label: 'Penjumlahan &\nPengurangan',
                      onTap: () {
                        _showPlaceholder(context, 'Penjumlahan & Pengurangan');
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.tag_rounded,
                      label: 'Ganjil/Genap &\nPrima',
                      iconText: '0',
                      onTap: () {
                        _showPlaceholder(context, 'Ganjil/Genap & Prima');
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.format_list_numbered_rounded,
                      label: 'Total Angka',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TotalAngkaPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.timer_rounded,
                      label: 'Stopwatch',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StopwatchPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.architecture_rounded,
                      label: 'Luas & Volume\nPiramid',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PiramidPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? iconText,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E5F3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: iconText != null
                  ? Center(
                      child: Text(
                        iconText,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5C6BC0),
                        ),
                      ),
                    )
                  : Icon(icon, color: const Color(0xFF5C6BC0), size: 28),
            ),
            const Spacer(),
            // Label
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction_rounded,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'Halaman $title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Segera hadir',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
