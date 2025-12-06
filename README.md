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
<img width="1919" height="1006" alt="Screenshot 2025-12-06 023544" src="https://github.com/user-attachments/assets/1ed08555-7b32-4b0e-a827-72a142acd8b0" />

<img width="1919" height="1008" alt="Screenshot 2025-12-06 023609" src="https://github.com/user-attachments/assets/db7f112d-8968-4cf1-8de9-15c9a6401570" />


**Penjelasan:** Formulir di RegistrasiPage mengharuskan input Nama, Email, Password, dan Konfirmasi Password. Validasi sisi klien memastikan password minimal 6 karakter dan email valid.

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
<img width="1919" height="1006" alt="Screenshot 2025-12-06 023624" src="https://github.com/user-attachments/assets/66c78adf-b8fe-42fd-b000-2d2ae6137074" />

**Penjelasan:**
Setelah RegistrasiBloc berhasil (Status 200 dari API), RegistrasiPage menampilkan SuccessDialog. Logika okClick digunakan untuk menutup dialog dan menyarankan pengguna pindah ke halaman login.

**Kode (Sukses):(lib/ui/registrasi_page.dart)**

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
**Kode (Gagal):(lib/ui/registrasi_page.dart)**

```dart
// ... di dalam _submit() function
RegistrasiBloc.registrasi(nama: ..., email: ..., password: ...).then(
  (value) {
    // ... Sukses
  },
  onError: (error) {
    // Menangkap kegagalan jaringan atau kegagalan API (Status Code 4xx/5xx)
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Registrasi gagal, silahkan coba lagi",
      ),
    );
  },
);
```
---

## 📝 **2. Proses Login**

Dikelola oleh **LoginPage** dan **LoginBloc**.

---

### a. **Input Data Pengguna**

**Screenshot:**  
<img width="1919" height="1006" alt="Screenshot 2025-12-06 023643" src="https://github.com/user-attachments/assets/33aa2c0a-af8d-44e7-a83e-9a65cb4aacc3" />

<img width="1919" height="1008" alt="Screenshot 2025-12-06 023528" src="https://github.com/user-attachments/assets/dfb04ca5-df78-4849-b508-e4004a083d15" />

**Penjelasan:**  
Pengguna menginputkan email dan password yang valid, kemudian menekan tombol "Login".

**Kode:**  
(login_page.dart): Fungsi _submit() dipanggil, yang memanggil LoginBloc.login().


---
### b. **Memanggil API Login**

**Endpoint:** /login (POST)

**Kode:** (lib/bloc/login_bloc.dart)
```dart
static Future<Login> login({String? email, String? password}) async {
  String apiUrl = ApiUrl.login;
  var body = {"email": email, "password": password};
  // Memanggil API POST untuk otentikasi
  var response = await Api().post(apiUrl, body); 
  var jsonObj = json.decode(response.body);
  return Login.fromJson(jsonObj);
}
```
---

### c. **Penanganan Hasil (Sukses/Gagal) dan Navigasi**

**Screenshot:**  
<img width="1919" height="1008" alt="Screenshot 2025-12-06 023234" src="https://github.com/user-attachments/assets/12b0a22e-54ca-4f38-b776-ae8b1f2fd8bc" />

<img width="1919" height="1007" alt="image" src="https://github.com/user-attachments/assets/82453f95-47fc-4d1f-8c67-864a1a10ba79" />

**Penjelasan:**  
Jika Login berhasil (Code 200), aplikasi menyimpan token dan User ID secara lokal menggunakan UserInfo().setToken() dan UserInfo().setUserID(). Kemudian, pushReplacement digunakan untuk menavigasi ke InventarisPage, menghapus LoginPage dari tumpukan.
  
**Kode Penanganan Sukses (login_page.dart):**
```dart
(value) async {
  if (value.code == 200) {
    // Simpan token dan ID pengguna secara lokal
    await UserInfo().setToken(value.token.toString());
    await UserInfo().setUserID(int.parse(value.userID.toString()));

    // Pindah ke halaman InventarisPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const InventarisPage()),
    );
  } else {
    // Tampilkan pesan error spesifik dari API
    showDialog(
      // ... menampilkan WarningDialog
      description: value.message ?? "Login gagal, silahkan coba lagi",
    );
  }
}
```

**Kode Penanganan Gagal (login_page.dart):**
```dart
// ... di dalam _submit() function
LoginBloc.login(email: ..., password: ...).then(
  (value) {
    if (value.code != 200) {
      // 1. Kegagalan Otentikasi API (misal: code 401)
      showDialog(
        context: context,
        builder: (BuildContext context) => WarningDialog(
          // Tampilkan pesan error spesifik dari API
          description: value.message ?? "Login gagal, silahkan coba lagi",
        ),
      );
    } 
    // ...
  },
  onError: (error) {
    // 2. Kegagalan Jaringan/Server (Exception)
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Terjadi kesalahan jaringan atau server, coba lagi nanti.",
      ),
    );
  },
);
```
---

## 📝 **3. Proses CRUD Inventaris Komputer**

Semua operasi CRUD menggunakan Model Inventaris (memiliki field nama, harga, jumlah, tanggalMasuk) dan diakses melalui endpoint /inventaris.

---

### a. **Read: Menampilkan Daftar Inventaris (List Produk)**

**Screenshot:**  
<img width="1919" height="1008" alt="Screenshot 2025-12-06 023234" src="https://github.com/user-attachments/assets/a00b9745-7b5c-4e43-8e8e-9b20dc0ea47a" />


**Penjelasan:**  
Halaman InventarisPage menampilkan daftar inventaris yang diambil dari API. Setiap item menampilkan Nama Barang, Harga, dan Jumlah. Item dapat diklik untuk melihat detail atau memicu tindakan Update/Delete.

**Kode Logika BLOC: (lib/bloc/inventaris_bloc.dart)**
```dart
static Future<List<Inventaris>> getInventarisList() async {
  String apiUrl = ApiUrl.listInventaris;
  // Menggunakan API GET, token otomatis terkirim
  var response = await Api().get(apiUrl); 
  var jsonObj = json.decode(response.body);

  // Mapping array JSON dari kunci 'data' ke List<Inventaris>
  List<dynamic> listData = (jsonObj as Map<String, dynamic>)['data'];
  List<Inventaris> items = [];

  for (int i = 0; i < listData.length; i++) {
    items.add(Inventaris.fromJson(listData[i]));
  }
  return items;
}
```

### b. **Create (Menambah Data Produk)**

**Screenshot:**  
<img width="1919" height="1009" alt="Screenshot 2025-12-06 023248" src="https://github.com/user-attachments/assets/7eaa5dcf-3993-46a4-952b-4279bb280f0c" />

<img width="1918" height="1004" alt="image" src="https://github.com/user-attachments/assets/261147bf-a79b-4972-819e-8e754ba9e2fb" />

**Penjelasan:**  
Di halaman InventarisForm (mode Tambah), pengguna mengisi data untuk Nama Barang, Harga, Jumlah, dan Tanggal Masuk. Fungsi simpan() memanggil InventarisBloc.addInventaris() menggunakan HTTP POST ke endpoint /inventaris.

**Kode Logika (Sukses): (lib/bloc/inventaris_bloc.dart)**
```dart
static Future addInventaris({Inventaris? item}) async {
  String apiUrl = ApiUrl.createInventaris; // Endpoint: /inventaris
  var body = {
    "nama": item!.nama,
    "harga": item.harga.toString(),
    "jumlah": item.jumlah.toString(), // Field Jumlah
    "tanggal_masuk": item.tanggalMasuk, // Field Tanggal Masuk
  };
  var response = await Api().post(apiUrl, body); // Menggunakan POST
  var jsonObj = json.decode(response.body);
  return jsonObj['status']; // Mengembalikan status sukses/gagal
}
```

**Kode Logika (Gagal): (lib/bloc/inventaris_bloc.dart)**
```dart
// ... di dalam _submit() function
InventarisBloc.addInventaris(item: newItem).then(
  (value) {
    // ... Sukses, navigasi
  },
  onError: (error) {
    // Menangkap kegagalan jaringan atau kegagalan API saat simpan
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Simpan gagal, silahkan coba lagi",
      ),
    );
  },
);
```

### c. **Read: Menampilkan Detail Produk (Show)**

**Screenshot:**  
<img width="1919" height="1011" alt="Screenshot 2025-12-06 023307" src="https://github.com/user-attachments/assets/d2820a97-3368-40cb-9bf1-e282a9604480" />


**Penjelasan:**  
Saat item di daftar diklik, pengguna dinavigasikan ke InventarisDetail. Halaman ini menampilkan detail lengkap item tunggal (Nama, Harga, Jumlah, Tanggal Masuk) serta tombol EDIT dan DELETE untuk memicu operasi lebih lanjut. Data item (Inventaris objek) dikirimkan langsung saat navigasi.

**Kode Navigasi Item: (lib/ui/inventaris_page.dart - di dalam ItemInventaris)**
```dart
@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail, membawa objek 'item' (Inventaris)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InventarisDetail(item: item)),
        );
      },
      // ... Tampilan card item inventaris
    );
  }
```

### d. **Update (Mengubah Data Produk)**

**Screenshot:**  
<img width="1919" height="997" alt="Screenshot 2025-12-06 023325" src="https://github.com/user-attachments/assets/3184d961-48a0-4a06-8005-85a855675d9e" />

<img width="1919" height="1006" alt="Screenshot 2025-12-06 023344" src="https://github.com/user-attachments/assets/cf9a4a19-c952-4ce4-8f0b-ba4045f32848" />

<img width="1919" height="1005" alt="Screenshot 2025-12-06 023400" src="https://github.com/user-attachments/assets/cfa5a922-8988-4ba6-ba8c-45a27ea5cb62" />

**Penjelasan:**  
Setelah menekan tombol EDIT di Detail, halaman InventarisForm dibuka dalam mode Ubah. Fungsi ubah() dipanggil, yang memanggil InventarisBloc.updateInventaris() menggunakan HTTP PUT ke endpoint spesifik (/inventaris/1, /inventaris/2, dst.).

**Kode Logika BLOC: (lib/bloc/inventaris_bloc.dart)
```dart
static Future updateInventaris({required Inventaris item}) async {
  // Membuat URL dinamis dengan ID item
  String apiUrl = ApiUrl.updateInventaris(int.parse(item.id!)); 
  
  var body = {
    "nama": item.nama,
    "harga": item.harga.toString(),
    "jumlah": item.jumlah.toString(), 
    "tanggal_masuk": item.tanggalMasuk,
  };
  
  // Menggunakan PUT dan body di-encode ke JSON string
  var response = await Api().put(apiUrl, jsonEncode(body)); 
  var jsonObj = json.decode(response.body);
  return jsonObj['status'];
}
```

### e. **Delete (Menghapus Data Produk)**

**Screenshot:**  
<img width="1919" height="1005" alt="Screenshot 2025-12-06 023400" src="https://github.com/user-attachments/assets/9707b464-1248-460f-a3dd-e3c00f863c53" />

<img width="1919" height="1010" alt="Screenshot 2025-12-06 023411" src="https://github.com/user-attachments/assets/5674bede-fc36-482c-989a-946822cf70c7" />

<img width="1919" height="1009" alt="Screenshot 2025-12-06 023425" src="https://github.com/user-attachments/assets/cdb6967b-7f9b-443b-8136-182d52d8b5d5" />

<img width="1919" height="1007" alt="Screenshot 2025-12-06 023438" src="https://github.com/user-attachments/assets/852a35f0-09f2-4291-870c-14d06da33c92" />

**Penjelasan:**  
Fungsi confirmHapus() menampilkan dialog konfirmasi. Setelah dikonfirmasi, InventarisBloc.deleteInventaris() dipanggil. Jika sukses, aplikasi menampilkan dialog "SUKSES: Hapus inventaris berhasil!" lalu menavigasi kembali ke InventarisPage dengan daftar yang diperbarui.

**Kode Logika BLOC : (lib/bloc/inventaris_bloc.dart)**
```dart
static Future<bool> deleteInventaris({int? id}) async {
  String apiUrl = ApiUrl.deleteInventaris(id!); // Endpoint spesifik dengan ID
  var response = await Api().delete(apiUrl); // Menggunakan DELETE
  var jsonObj = json.decode(response.body);
  // Mengembalikan nilai boolean status penghapusan
  return jsonObj['status'] ?? false; 
}
```
---

## 📝 **4. Proses Logout**

**Screenshot:**

<img width="1919" height="1005" alt="Screenshot 2025-12-06 023451" src="https://github.com/user-attachments/assets/df0f4331-1809-4a96-9931-973c021f565e" />

<img width="1919" height="1006" alt="Screenshot 2025-12-06 023509" src="https://github.com/user-attachments/assets/4f8f2213-a88a-4513-b25d-ee9f53f0c7ce" />

**Penjelasan:**
Pengguna memilih opsi "Logout" dari Drawer menu. Proses ini secara fundamental menghancurkan sesi otentikasi yang tersimpan di perangkat.

**Menghapus Sesi Lokal:(lib/bloc/logout_bloc.dart)**
```dart
class LogoutBloc {
  static Future logout() async {
    // Memanggil UserInfo untuk membersihkan data sesi
    await UserInfo().logout(); 
  }
}
```

**Navigasi Kembali ke Login:**

Setelah sesi berhasil dihapus, aplikasi melakukan navigasi ke LoginPage. Metode navigasi yang digunakan adalah pushAndRemoveUntil, yang memastikan semua halaman sebelumnya (termasuk InventarisPage) dihapus dari tumpukan, sehingga pengguna tidak dapat kembali ke halaman produk tanpa login ulang.

**Kode Navigasi**
```dart
onTap: () async {
  // Logika Logout: panggil bloc
  await LogoutBloc.logout().then(
    (value) => {
      // Navigasi ke LoginPage, menghapus semua rute sebelumnya
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false, 
      ),
    },
  );
},
```




