class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;
  String? message; // Menangkap pesan dari API

  Login({
    this.code,
    this.status,
    this.token,
    this.userID,
    this.userEmail,
    this.message,
  });

  factory Login.fromJson(Map<String, dynamic> obj) {
    if (obj['code'] == 200) {
      // Login Berhasil
      return Login(
        code: obj['code'],
        status: obj['status'],
        token: obj['data']['token'],
        // Mengambil langsung dari obj['data']
        userID: int.parse(obj['data']['id'].toString()),
        userEmail: obj['data']['email'],
        message: obj['message'], // Mengambil pesan sukses
      );
    } else {
      // Login Gagal (Code 401, 400, dll.)
      return Login(
        code: obj['code'],
        status: obj['status'],
        message: obj['message'], // Menangkap pesan error spesifik
      );
    }
  }
}
