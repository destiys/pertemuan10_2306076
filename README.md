# Aplikasi Login Flutter

## Deskripsi
Aplikasi login sederhana berbasis Flutter yang menggunakan SharedPreferences untuk menyimpan session login pengguna secara lokal.

# Fitur Aplikasi
- Login Username dan Password
- Validasi Form Login
- Show / Hide Password
- Menyimpan Session Login
- Menampilkan Username pada Home Page
- Logout Session

# Penjelasan Singkat
## Login Page
Halaman login digunakan untuk memasukkan username dan password.  
Form menggunakan validator untuk memeriksa:
- Username tidak boleh kosong
- Username minimal 4 karakter
- Password tidak boleh kosong
- Password minimal 6 karakter
Password dapat ditampilkan atau disembunyikan menggunakan icon visibility.

## Home Page
Halaman home menampilkan:
- Username pengguna
- Foto profile
- Tombol logout

Saat logout ditekan, session login akan dihapus dan pengguna kembali ke halaman login.

# Konsep Flutter yang Digunakan
- StatefulWidget
- Form Validation
- SharedPreferences
- Navigation
- TextEditingController
- setState()

# Hasil
Aplikasi berhasil:
- Menampilkan form login modern
- Melakukan validasi username dan password
- Menyimpan status login pengguna
- Menampilkan halaman home setelah login
- Logout dan menghapus session login
