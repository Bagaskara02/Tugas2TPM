# Aplikasi Kalkulasi (Tugas 2 TPM)

Aplikasi berbasis Flutter yang menyediakan berbagai macam fitur kalkulasi matematis dan utilitas. Aplikasi ini dirancang dengan antarmuka pengguna yang modern serta dilengkapi dengan sistem *Error Handling* (Penanganan Kesalahan) yang komprehensif agar tahan terhadap berbagai skenario *edge-case* atau input berlebih.

## ✨ Fitur Utama

1. **Sistem Login** 🔐
   - Autentikasi sederhana menggunakan **NIM** sebagai *Username* dan **3 digit terakhir NIM** sebagai *Password*.
   - Dilengkapi proteksi internal sehingga kebal terhadap *RangeError* meskipun NIM kurang dari 3 digit.

2. **Daftar Data Kelompok** 👥
   - Menampilkan daftar anggota penyusun tugas menggunakan animasi transisi masuk (Fade & Slide) yang dinamis.

3. **Penjumlahan & Pengurangan** ➕➖
   - Kalkulator dasar dua variabel dengan pengenalan nilai tak terhingga (*Large Numbers*).
   - Akan otomatis melakukan konversi ke **Scientific Notation** (`e+...`) ketika angka input maupun hasil mencapai lebih dari 12 digit untuk melindungi antarmuka dari *overflow*.

4. **Kalkulator Total Angka** 🧮
   - Mampu mengekstrak sekumpulan angka secara otomatis dari satu teks panjang.
   - Mendukung berbagai pemisah seperti Koma `,`, Titik `.`, dan Titik Koma `;`.
   - Dilengkapi validasi ketat terhadap kelebihan spasi, format ganda (*trailing separator*), dan batas maksimal pemrosesan hingga 50 rentet angka agar hitungan tetap seimbang.

5. **Pengecek Bilangan (Ganjil/Genap & Prima)** 🔢
   - Melakukan observasi pembagian sisa terhadap sifat suatu bilangan tunggal.
   - Menggunakan *Guard Limit* (batas atas nilai 1 Miliar) pada logika penentuan Bilangan Prima guna mencegah *Freeze / Hang* perangkat akibat komputasi miliaran *loop*.

6. **Luas & Volume Piramid** 📐
   - Menghitung dimensi tiga bangun ruang (Piramid Alas Persegi & Persegi Panjang).
   - Parameter input dilindungi dari kemungkinan *Null*, angka O (Nol) maupun bilangan Negatif karena tidak logis dalam hukum bangun ruang fisik.

7. **Stopwatch** ⏱️
   - Pengukur waktu presisi hingga nilai ratusan sekon.
   - Mendukung sistem pencatatan putaran rekaman (*Lap*) tanpa henti.

## 🛠️ Stack Teknologi & Keamanan
- **Framework:** Flutter / Dart
- **UI/UX Strategy:** Modern Flat Design Colors, `FittedBox` Scaling Text (Anti-Overflow Layout).
- **Math Safety:** Memiliki filtrasi *Regex Space Validation*, batas angka perhitungan 1.000.000.000 (*1 Billion Boundary*), penjaga iterasi Loop, serta konverter `.toStringAsExponential()`. 

## 🚀 Cara Menjalankan

1. Pastikan Flutter SDK telah terinstal di komputer.
2. Lakukan clone repositori ini.
3. Buka terminal pada folder awal (_root_) proyek dan jalankan perintah:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi pada Emulator atau _Physical Device_:
   ```bash
   flutter run
   ```
