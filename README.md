# Responsi 2 Mobile Paket 1

## 💻 Inventaris Komputer Mobile App (CRUD Flutter & CodeIgniter 4 API)

Aplikasi mobile untuk manajemen inventaris barang kategori komputer, dibangun menggunakan **Flutter** dan terintegrasi dengan **RESTful API** menggunakan **CodeIgniter 4**. Aplikasi ini mengimplementasikan penuh **fitur CRUD** dan **Otentikasi** sesuai persyaratan ujian.

---

## Identitas
* Nama  : Ayu Fitrianingsih
* NIM  : H1D023038
* Shift  : B/E
* Linf vidio : https://drive.google.com/drive/folders/1vQ9GX3ceU7jVsjnqWSnrMRmZO9lHfvgd?usp=drive_link
  
---

## ✨ Fitur Utama

* **Autentikasi Pengguna:**
    * **Registrasi:** Pendaftaran pengguna baru.
    * **Login:** Menggunakan email dan password untuk mendapatkan token.
* **Manajemen Produk (CRUD):**
    * Melihat **Daftar** semua produk.
    * **Menambah** produk baru (Create).
    * Melihat **Detail** produk.
    * **Mengubah** data produk (Update).
    * **Menghapus** produk (Delete).
* **Skema Data:** Mendukung 4 field wajib (nama, harga, jumlah, tanggal_masuk).
* **Skema Data:** Menggunakan skema warna abu-abu pada Action Bar dan tombol.
* **Navigasi:** Drawer menu untuk Logout.
* **Validasi Formulir:** Validasi sisi klien pada form Registrasi dan Login.

---

## 🛠️ Teknologi yang Digunakan

### Frontend (Aplikasi Mobile)
| Teknologi | Keterangan |
| :--- | :--- |
| **Flutter** | Framework UI untuk membangun aplikasi multi-platform. |
| **Dart** | Bahasa pemrograman inti Flutter. |
| **`http` Package** | Untuk melakukan permintaan HTTP ke API. |
| **Provider/Bloc** | [State Management yang Anda gunakan, contoh: **Provider** / **Bloc**] |
| **shared_preferences** | Untuk menyimpan session (token, userID) secara lokal. |

---

### Backend (RESTful API)
| Teknologi | Keterangan |
| :--- | :--- |
| **CodeIgniter 4** | Framework PHP untuk membangun RESTful API. |
| **MySQL** | Database yang digunakan untuk menyimpan data produk dan pengguna. |
| **XAMPP** | Server lokal (Apache & MySQL) untuk menjalankan API. |

---

## ⚙️ Persyaratan Sistem

Pastikan lingkungan pengembangan Anda sudah terinstal:

1.  **Flutter SDK:** Versi [Isi dengan versi Flutter Anda, contoh: **3.22.6**].
2.  **Android Studio / VS Code:** Dengan plugin Flutter dan Dart.
3.  **XAMPP / Web Server:** Untuk menjalankan CodeIgniter 4 API.
4.  **PHP:** Versi [Isi dengan versi PHP Anda, contoh: **7.4+**].

---

## 🚀 Panduan Instalasi dan Menjalankan Proyek

### 1. Setup Backend (CodeIgniter 4 API)

1.  **Server Local:** Pastikan Apache dan MySQL sudah berjalan di XAMPP.
2.  **API Project:** Tempatkan folder `supermarke-komputer` (proyek CodeIgniter 4 Anda) di direktori `C:\xampp\htdocs\`.
3.  **Database:** Buat database bernama `supermarket_komputer` dan jalankan script SQL untuk membuat tabel `member`, dan `inventaris_komputer`.
    * *Keterangan*: Pastikan file konfigurasi database CodeIgniter 4 (`app/Config/Database.php`) sudah terhubung dengan database `supermarket_komputer`.
4.  **Uji Akses:** Coba akses API melalui browser : `http://localhost/supermarket-komputer/public/registrasi`

### 2. Setup Frontend (Flutter App)

1.  **Clone Repositori:**
    ```bash
    git clone [https://github.com/ldclabs/anda](https://github.com/ldclabs/anda)
    cd responsi2_paket1_h1d023038
    ```
2.  **Install Dependensi:**
    ```bash
    flutter pub get
    ```
3.  **Konfigurasi API URL:**
    * Buka file `lib/helpers/api_url.dart`
    * Ubah `localhost` menjadi alamat IP yang sesuai jika Anda menggunakan perangkat fisik atau emulator Android.
        ```dart
        final String _baseUrl = "http://[IP/HOST ANDA]/supermarket-komputer/public";
        ```
4.  **Jalankan Aplikasi:**
    ```bash
    flutter run
    ```
    
---

## 🔑 **1. Registrasi (Create User)**

### a. **Input Data Pengguna**

**Screenshot:**  

**Penjelasan:** Formulir di RegistrasiPage mengharuskan input Nama, Email, Password, dan Konfirmasi Password. Validasi sisi klien memastikan password minimal 6 karakter dan email valid.

Pengguna mengisi:

- Nama
- Email
- Password
- Konfirmasi Password

Validasi:

- Password minimal 6 karakter
- Konfirmasi password harus sama
- Email valid

---

### b. **Memanggil API Registrasi**

Endpoint:
/registrasi(POST)

Kode:(lib/bloc/registrasi_bloc.dart)

```dart
static Future<Registrasi> registrasi({
  String? nama,
  String? email,
  String? password,
}) async {
  String apiUrl = ApiUrl.registrasi;
  var body = {"nama": nama, "email": email, "password": password};
  // Menggunakan Api().post untuk mengirim data ke CI4
  var response = await Api().post(apiUrl, body); 
  var jsonObj = json.decode(response.body);
  return Registrasi.fromJson(jsonObj);
}
```

### c. **Penanganan Hasil (Pop-up Sukses)**

**Screenshot:**  


**Penjelasan:**
Setelah RegistrasiBloc berhasil (Status 200 dari API), RegistrasiPage menampilkan SuccessDialog. Logika okClick digunakan untuk menutup dialog dan menyarankan pengguna pindah ke halaman login.

Kode:(lib/ui/registrasi_page.dart)

```dart
).then(
  (value) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SuccessDialog(
        description: "Registrasi berhasil, silahkan login",
        okClick: () {
          // Menutup dialog dan kembali ke halaman login/awal
          Navigator.pop(context); 
        },
      ),
    );
  },
  // ... Penanganan Error (menampilkan WarningDialog)
);
```


