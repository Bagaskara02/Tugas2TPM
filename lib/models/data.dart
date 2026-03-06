class User {
  String username;
  String password;
  String nama;

  User({required this.username, required this.password, required this.nama});
}

User user1 = User(
  username: 'Admin',
  password: '123',
  nama: 'Admin',
);

class AnggotaKelompok {
  String nama;
  String nim;

  AnggotaKelompok({required this.nama, required this.nim});
}

final List<AnggotaKelompok> kelompokData = [
  AnggotaKelompok(nama: 'AFIF KHALIQ RAMADHAN', nim: '123230177'),
  AnggotaKelompok(nama: 'MUHAMMAD BAGASKARA DAFFA ARYANTO', nim: '123230180'),
  AnggotaKelompok(nama: 'YUSRON ATHALLAH ', nim: '123230'),
];
