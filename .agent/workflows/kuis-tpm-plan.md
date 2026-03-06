---
description: Workflow rencana pengerjaan tugas Kuis TPM - Aplikasi Dart/Flutter
---

# Rencana Pengerjaan Kuis TPM

## Phase 1: Login, Home Dashboard, Stopwatch ✅

1. Setup project: tambah dependency `google_fonts` di `pubspec.yaml`
// turbo
2. Jalankan `flutter pub get`
3. Update `lib/models/data.dart` — hapus model Product, tambah model AnggotaKelompok
4. Update `lib/main.dart` — konfigurasi font Poppins dan tema indigo
5. Redesign `lib/login.dart` — UI sesuai mockup (ikon graduation cap, field styled, tombol gradient)
6. Rewrite `lib/home.dart` — grid 6 menu dashboard (Data Kelompok, Penjumlahan & Pengurangan, Ganjil/Genap & Prima, Total Angka, Stopwatch, Luas & Volume Piramid)
7. Buat `lib/stopwatch_page.dart` — stopwatch dengan display HH:MM:SS.cs, tombol Start/Stop/Reset
// turbo
8. Jalankan `flutter analyze` untuk verifikasi
9. Test manual: `flutter run -d windows` atau emulator

## Phase 2: Feature Pages

10. Buat `lib/pages/data_kelompok_page.dart` — tampilkan daftar anggota kelompok dari model data
11. Buat `lib/pages/penjumlahan_pengurangan_page.dart` — input 2 angka, hitung +/-
12. Buat `lib/pages/ganjil_genap_prima_page.dart` — input angka, cek ganjil/genap dan prima
13. Buat `lib/pages/total_angka_page.dart` — input banyak angka, hitung total
14. Buat `lib/pages/piramid_page.dart` — input dimensi, hitung luas permukaan dan volume piramid
15. Update `lib/home.dart` — hubungkan semua menu ke halaman masing-masing

## Phase 3: Cleanup & Polish

16. Hapus file tidak terpakai (`detail.dart`, `profile.dart`, `root.dart`)
17. Final testing semua fitur
18. Build APK: `flutter build apk`

## Login Credentials

- Username: `budi123`
- Password: `password123`
