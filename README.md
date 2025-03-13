# Pemrograman Visual dan Piranti Bergerak

---

## 📚 Quiz 1

---

### Kelompok 66 Kelas Kamis

Proyek ini dikembangkan oleh kelompok 66 sebagai bagian dari tugas Quiz 1 untuk praktikum pada mata kuliah Pemrograman Visual dan Piranti Bergerak. Adapun anggota dari kelompok kami adalah:

- **2307589 Fariz Wibisono**
- **2309245 Hasbi Haqqul Fikri**

## ⛺ Deskripsi Aplikasi

---

Aplikasi **Camping Gear Rental** adalah aplikasi berbasis Flutter yang memungkinkan pengguna untuk menyewa berbagai alat perkemahan dengan mudah. Aplikasi ini memiliki fitur seperti detail item, review dan rating, chat dengan admin, daftar wishlist, keranjang & checkout, promosi, serta daftar transaksi.

## 📌 Fitur Utama

---

✅ **Halaman Depan** – Menampilkan navigasi utama ke semua fitur.  
✅ **Detail Item** – Informasi lengkap tentang alat perkemahan, termasuk gambar, spesifikasi, dan harga sewa.  
✅ **Review & Rating** – Ulasan dari penyewa sebelumnya dalam format list view dengan bintang rating.  
✅ **Chat dengan Admin** – Fitur komunikasi langsung bagi pengguna, terutama bagi pemula dalam perkemahan.  
✅ **Wishlist** – Menyimpan item favorit untuk disewa nanti.  
✅ **Keranjang & Checkout** – Menampilkan daftar barang yang akan disewa dengan opsi pembayaran.  
✅ **Paket Hemat & Promosi** – Menampilkan berbagai penawaran spesial.  
✅ **Daftar Transaksi** – Melacak status pesanan, pengembalian barang, dan riwayat transaksi.

## 🛠 Teknologi yang Digunakan

---

- **Flutter** 3.29
- **Dart**
- **State Management:** Provider atau GetX
- **Navigation:** Flutter Router
- **UI Components:** Material Design 3

## 🚀 Cara Install dan Menjalankan Aplikasi

---

### 1️⃣ **Clone Repository**

```bash
git clone https://github.com/frzxw/quiz_provis_c1_2025.git
cd quiz_provis_c1_2025
```

### 2️⃣ **Install Dependencies**

Pastikan Anda telah menginstal Flutter versi **3.29**. Jika belum, unduh Flutter dari [situs resmi](https://flutter.dev/docs/get-started/install). Setelah itu, jalankan perintah berikut:

```bash
flutter pub get
```

### 3️⃣ **Menjalankan Aplikasi**

Jalankan aplikasi di emulator atau perangkat fisik dengan perintah berikut:

```bash
flutter run
```

## 📂 Struktur Folder

---

```
/lib
│── main.dart                # Entry point aplikasi
│── /screens                 # Folder untuk semua tampilan UI
│   │── home_screen.dart      # Halaman utama
│   │── detail_screen.dart    # Halaman detail item
│   │── cart_screen.dart      # Halaman keranjang
│   │── chat_screen.dart      # Halaman chat admin
│   │── transactions_screen.dart  # Halaman daftar transaksi
│   │── checkout_screen.dart         # Halaman checkout
│   │── item_detail_screen.dart      # Halaman detail item
│   │── navigation_screen.dart       # Halaman navigasi
│   │── order_monitoring_screen.dart # Halaman pemantauan pesanan
│   │── package_purchase_screen.dart # Halaman pembelian paket
│   │── promotions_screen.dart       # Halaman promosi
│   │── returns_screen.dart          # Halaman daftar pengembalian barang
│   │── review_screen.dart           # Halaman ulasan
│   │── wishlist_screen.dart         # Halaman wishlist
│── /widgets                 # Komponen UI yang dapat digunakan ulang
│── /models                  # Model data aplikasi
│── /providers               # State management
│── /routes                  # Konfigurasi navigasi
/assets                  # Gambar dan ikon
│── /images # Folder untuk penyimpanan gambar
```

## 📜 Lisensi

MIT License – Bebas digunakan dan dikembangkan lebih lanjut.
