import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  // 1. Menyimpan Token Otentikasi
  Future<bool> setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Menggunakan key "token" untuk menyimpan string
    return pref.setString("token", value);
  }

  // 2. Mengambil Token Otentikasi
  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Mengambil nilai string dengan key "token"
    return pref.getString("token");
  }

  // 3. Menyimpan ID Pengguna (User ID)
  Future<bool> setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Menggunakan key "userID" untuk menyimpan integer
    return pref.setInt("userID", value);
  }

  // 4. Mengambil ID Pengguna (User ID)
  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Mengambil nilai integer dengan key "userID"
    return pref.getInt("userID");
  }

  // 5. Menghapus Semua Data (Logout)
  Future<bool> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Membersihkan semua data yang disimpan oleh aplikasi
    return pref.clear();
  }
}
