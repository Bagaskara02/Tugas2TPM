# Handoff untuk Yusron - Tugas TPM

Halo Yusron! 👋 Berikut panduan untuk mengerjakan bagianmu.

## Status Project Saat Ini

Project sudah punya:
- ✅ Login (Admin/123)
- ✅ Home dashboard (6 menu grid)
- ✅ Data Kelompok
- ✅ Stopwatch (dengan lap)
- ✅ Luas & Volume Piramid
- ✅ Total Angka
- 🔲 **Penjumlahan & Pengurangan** ← bagianmu
- 🔲 **Ganjil/Genap & Prima** ← bagianmu

## Yang Perlu Kamu Buat

### 1. Penjumlahan & Pengurangan
**File:** `lib/pages/penjumlahan_pengurangan_page.dart`

**Spesifikasi:**
- Input 2 angka (TextField, keyboardType number)
- Tombol Tambah (+) dan Kurang (-)
- Tampilkan hasil perhitungan

**Contoh class name:** `PenjumlahanPenguranganPage`

### 2. Ganjil/Genap & Bilangan Prima
**File:** `lib/pages/ganjil_genap_prima_page.dart`

**Spesifikasi:**
- Input 1 angka
- Cek apakah ganjil atau genap
- Cek apakah bilangan prima atau bukan
- Tampilkan hasilnya

**Contoh class name:** `GanjilGenapPrimaPage`

---

## Cara Menghubungkan ke Home

Di `lib/home.dart`:

### 1. Tambah import di bagian atas file:
```dart
import 'pages/penjumlahan_pengurangan_page.dart';
import 'pages/ganjil_genap_prima_page.dart';
```

### 2. Ganti `_showPlaceholder` menjadi `Navigator.push`:

**Penjumlahan & Pengurangan** (sekitar baris 75-77):
```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PenjumlahanPenguranganPage(),
    ),
  );
},
```

**Ganjil/Genap & Prima** (sekitar baris 84-86):
```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const GanjilGenapPrimaPage(),
    ),
  );
},
```

---

## Konvensi Kode & Styling

### Warna tema utama:
```dart
const Color(0xFF5C6BC0)  // Indigo - warna utama
const Color(0xFFE8E5F3)  // Light purple - background icon
const Color(0xFFF7F7F9)  // Light grey - background halaman
```

### Template halaman:
```dart
import 'package:flutter/material.dart';

class NamaPage extends StatefulWidget {
  const NamaPage({super.key});

  @override
  State<NamaPage> createState() => _NamaPageState();
}

class _NamaPageState extends State<NamaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F9),
      appBar: AppBar(
        title: const Text(
          'Judul Halaman',
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
          children: [
            // konten di sini
          ],
        ),
      ),
    );
  }
}
```

### Style input field:
```dart
TextField(
  controller: _controller,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: 'Label',
    prefixIcon: Icon(Icons.numbers, color: Color(0xFF5C6BC0)),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFE8E8E8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFE8E8E8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFF5C6BC0), width: 2),
    ),
  ),
),
```

### Style tombol:
```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF5C6BC0),
    foregroundColor: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  child: Text('Hitung'),
),
```

---

## Cara Test
```bash
flutter analyze    # cek error
flutter run -d windows   # atau emulator
```

Login: **Username:** `Admin` | **Password:** `123`

Semangat! 💪
