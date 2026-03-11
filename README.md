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

## Fitur Aplikasi
Aplikasi ini sudah mencakup beberapa menu utama dengan UI yang **telah diperbarui (Modernized Layered UI)** dan dilengkapi *Error Handling*:

1. **Menu Login (Auth):**
   - Validasi logika kredensial (hanya `tugas1 / 6`).
   - Penambahan validasi lengkap menolak spasi/form kosong.
2. **Menu Home (Dashboard):**
   - Menampilkan data **Kelompok Project (4 Orang)**.
   - Menu list modern dengan *drop shadow*.
3. **Menu Penjumlahan dan Pengurangan (Kalkulator):**
   - Menjumlahkan `+` dan mengurangkan `-` angka.
   - Penanganan error komprehensif untuk mencegah input non-angka atau tak terhingga.
4. **Menu Analisis Bilangan:**
   - Memasukkan angka untuk mengecek apakah bilangan Ganjil/Genap dan Prima/Bukan Prima.
5. **Menu Total Angka dalam List:**
   - Input deretan angka dipisah koma (contoh: `1,2,3,4`) lalu dijumlahkan total digitnya.
6. **Menu Stopwatch:**
   - Timer akurat dengan milidetik.
   - Menyediakan fitur Pause dan pencatatan riwayat Lap.
7. **Menu Kalkulator Piramid:**
   - Menghitung Luas Permukaan dan Volume Limas Segiempat.
   - UI Baru: Label lebih ringkas (**Sisi Alas, Tinggi, L. Permukaan, Volume**).
   - *Auto-scaling text* (FittedBox) untuk mencegah overflow pada angka ribuan/jutaan.

---

## Cara Menjalankan Aplikasi
*(Lanjutkan seperti instruksi sebelumnya...)*
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
   *(Opsional)* Jika terjadi error versi Java `Unsupported class file major version 69`, konfigurasi Flutter JDK Anda:
   ```bash
   flutter config --jdk-dir "C:\Program Files\Android\Android Studio\jbr"
   ```
3. **Hubungkan Device.** Jika menggunakan VSCode/Android Studio, pastikan Anda menghubungkan *Emulator* (Android/iOS) atau *Device fisik* (menggunakan kabel/wireless debugging). Anda juga bisa menjalankannya via Browser jika Desktop Support aktif (`Google Chrome`).
4. **Jalankan Aplikasi:**
   Ketikkan perintah berikut di terminal path Anda untuk me-compile proyek:
   ```bash
   flutter run
   ```

---

## Struktur Folder
Struktur proyek terpisah per-fitur agar kode lebih rapi dan bersih.
```text
lib/
 ├── core/
 │    └── constants/
 │         └── app_colors.dart        # (Tema Pusat: Deep Sea Blue & White)
 ├── features/
 │    ├── auth/
 │    │    └── login_screen.dart      # (Logika & Desain Form Login)
 │    ├── home/
 │    │    └── home_screen.dart       # (Dashboard navigasi menu)
 │    ├── calculator/
 │    │    └── calculator_screen.dart # (Fungsional + dan -)
 │    ├── digit_sum/
 │    │    └── digit_sum_screen.dart  # (Perhiungan Total List Angka)
 │    ├── number_properties/
 │    │    └── number_properties_screen.dart # (Cek Prima, Ganjil & Genap)
 │    ├── stopwatch/
 │         └── stopwatch_screen.dart  # (Fitur UI Timer berlapis Modern)
 │    └── pyramid/
 │         └── pyramid_calculator_screen.dart # (Kalkulator Luas & Volume Limas)
 └── main.dart                        # (Entry/Root awal aplikasi)
```
Masing-masing file berekstensi `.dart` sudah diberikan komentar fungsional untuk menunjang kebutuhan struktur modular aplikasi.
