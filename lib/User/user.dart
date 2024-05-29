
// Model Pengguna
class User {
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });
}

// Simpan Data Pengguna
List<User> users = [];

// Fungsi untuk Mendaftarkan Pengguna
void registerUser(String name, String email, String password) {
  // Hash password
  String hashedPassword = hashPassword(password);
  // Buat objek pengguna baru dan tambahkan ke daftar pengguna
  users.add(User(name: name, email: email, password: hashedPassword));
}

// Fungsi untuk Memeriksa Kredensial Pengguna saat Login
User? loginUser(String email, String password) {
  // Cari pengguna dengan email yang cocok
  User? user;
  try {
    user = users.firstWhere((user) => user.email == email);
  } catch (e) {
    // Jika tidak ada pengguna yang ditemukan, kembalikan null
    return null;
  }
  
  // Cocokkan password
  if (user.password == password) {
    return user;
  }
  
  return null;
}


// Fungsi untuk meng-hash password
String hashPassword(String password) {
  // Implementasi hashing password
  // Misalnya: gunakan library bcrypt atau library hashing lainnya
  // Contoh sederhana:
  return password; // Diganti dengan hasil hashing yang sebenarnya
}
