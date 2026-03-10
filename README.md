# TP Mobile - Tugas 1

Aplikasi berbasis mobile yang dibangun menggunakan **Flutter (Bahasa Dart)**. Proyek kode ini disusun menggunakan struktur folder **modular** untuk kemudahan pengelolaan dan pemeliharaan logika di masa mendatang. Warna UI utama aplikasi ini adalah **Biru Laut** dengan warna pendukung **Putih**.

Aplikasi ini mencakup beberapa fitur yang diperuntukkan memenuhi Tugas 1 pada mata kuliah Pemrograman Mobile.

---

## Kredensial Login
Untuk masuk ke dalam aplikasi dan melihat halaman dashboard, Anda perlu memasukkan kredensial berikut:
- **Username:** `tugas1`
- **Password:** `6`

_Catatan: Jika dikosongkan atau diisi selain kredensial di atas, aplikasi akan menampilkan peringatan "Username atau password salah!"_

---

## Fitur yang Sudah Ada
Sesuai kriteria tugas yang difokuskan pada tahap awal ini, fitur berikut sudah **sepenuhnya fungsional**, beserta dengan penjelasan logika di setiap baris kodenya (komentar) agar mudah dipelajari:

1. **Menu Login (Auth):**
   - Terdapat kolom input `username` dan `password` (ter-obfuscate).
   - Validasi logika kredensial agar hanya `tugas1 / 6` yang bisa masuk ke menu Home.
2. **Menu Home (Dashboard):**
   - Menampilkan data **Kelompok Project (4 Orang)**.
   - Tombol logout untuk kembali ke halaman login.
   - Navigasi menuju halaman kalkulator operasi sederhana.
3. **Menu Penjumlahan dan Pengurangan (Kalkulator):**
   - Form input Angka Pertama dan Angka Kedua.
   - Modul interaktif untuk menjumlahkan `+` dan mengurangkan `-`.
   - Menampilkan hasil operasi secara Real-time dengan UI warna laut.

---

## Fitur yang Belum Ada
Beberapa menu berikut termasuk ke dalam total kriteria poin tugas, namun belum digarap pada aplikasi/versi saat ini:
- [ ] Menu input bilangan ganjil/genap dan bilangan prima
- [ ] Menu jumlah total angka dalam suatu field input data (List Angka)
- [ ] Menu Stopwatch
- [ ] Menu hitung Luas dan Volume Piramid

---

## Cara Menjalankan Aplikasi
Dikarenakan proyek ini berjalan di atas Flutter Framework, pastikan Anda sudah menginstal **Flutter SDK** di lokal Anda sebelum menjalankannya untuk proyek GitHub ini.

1. **Clone/Download** *repository* ini ke komputer lokal Anda:
   ```bash
   git clone <url-repository-anda>
   cd tpm_tugas1
   ```
2. **Unduh Dependencies** proyek dengan cara mendownload seluruh package yang diperlukan melalui terminal/CMD:
   ```bash
   flutter pub get
   ```
3. **Hubungkan Device.** Jika menggunakan VSCode/Android Studio, pastikan Anda menghubungkan *Emulator* (Android/iOS) atau *Device fisik* (menggunakan kabel/wireless debugging). Anda juga bisa menjalankannya via Browser jika Desktop Support aktif (`Google Chrome`).
4. **Jalankan Aplikasi:**
   Ketikkan perintah berikut di terminal path Anda untuk me-compile proyek:
   ```bash
   flutter run
   ```

---

## 📂 Struktur Folder
Struktur proyek terpisah per-fitur agar kode lebih rapi dan bersih.
```text
lib/
 ├── core/
 │    └── constants/
 │         └── app_colors.dart        # (Pusat konstanta warna aplikasi)
 ├── features/
 │    ├── auth/
 │    │    └── screens/
 │    │         └── login_screen.dart # (Logika form & UI Login)
 │    ├── home/
 │    │    └── screens/
 │    │         └── home_screen.dart  # (Dashboard navigasi & Data Kelompok)
 │    └── calculator/
 │         └── screens/
 │              └── calculator_screen.dart # (Fungsional Penjumlahan&Pengurangan)
 └── main.dart                        # (Entry/Root awal aplikasi)
```
Masing-masing file berekstensi `.dart` sudah diberikan dokumentasi komentar berbahasa Indonesia di setiap segmen fungsionalitasnya untuk menunjang kebutuhan pembelajaran.
