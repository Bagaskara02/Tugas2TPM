class AnggotaKelompok {
  String nama;
  String nim;

  AnggotaKelompok({required this.nama, required this.nim});

  /// Password = 3 digit terakhir NIM (atau seluruh NIM jika kurang dari 3 digit)
  String get password => nim.length >= 3 ? nim.substring(nim.length - 3) : nim;
}

final List<AnggotaKelompok> kelompokData = [
  AnggotaKelompok(nama: 'AFIF KHALIQ RAMADHAN', nim: '123230177'),
  AnggotaKelompok(nama: 'MUHAMMAD BAGASKARA DAFFA ARYANTO', nim: '123230180'),
  AnggotaKelompok(nama: 'YUSRON ATHALLAH ', nim: '123230183'),
];
