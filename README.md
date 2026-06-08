# pertemuan10_2306133
<img width="917" height="952" alt="WhatsApp Image 2026-05-27 at 04 03 11" src="https://github.com/user-attachments/assets/7fe3ea83-8a06-4b26-b931-1dfe793a8e8a" />
<img width="919" height="855" alt="WhatsApp Image 2026-05-27 at 04 04 51" src="https://github.com/user-attachments/assets/0d7b50fc-1067-4434-8c54-0801113352f0" />

A new Flutter project.

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
