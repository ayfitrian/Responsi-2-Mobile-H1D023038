import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:responsi2_paket1_h1d023038/helpers/user_info.dart';
import 'package:responsi2_paket1_h1d023038/helpers/app_exception.dart';
import 'dart:convert';

class Api {
  // Method POST untuk mengirim data baru
  Future<dynamic> post(dynamic url, dynamic data) async {
    // 1. Ambil token otentikasi
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        // 2. Encode body data menjadi JSON string untuk API (seperti pada modul)
        body: jsonEncode(data),
        headers: {
          // 3. Tambahkan header Authorization dan Content-Type
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      // Menangkap error jika tidak ada koneksi internet
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Method GET untuk mengambil data
  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          // Tambahkan header Authorization
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Method PUT untuk mengubah data
  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      final response = await http.put(
        Uri.parse(url),
        // Asumsi data sudah berupa JSON string (di-encode di BLoC sebelum dipanggil)
        body: data,
        headers: {
          // Tambahkan header Authorization dan Content-Type
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Method DELETE untuk menghapus data
  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          // Tambahkan header Authorization
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Fungsi internal untuk memproses respons HTTP dan menangani error
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: // OK
      case 201: // Created
        return response;
      case 400: // Bad Request
        throw BadRequestException(response.body.toString());
      case 401: // Unauthorized
      case 403: // Forbidden
        throw UnauthorisedException(response.body.toString());
      case 422: // Unprocessable Entity (Input Validation Error)
        throw InvalidInputException(response.body.toString());
      case 500: // Internal Server Error
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}',
        );
    }
  }
}
