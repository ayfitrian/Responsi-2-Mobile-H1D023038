class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([
    this._message,
    this._prefix,
  ]); // Konstruktor untuk inisialisasi pesan dan prefix [cite: 83, 84, 85]

  @override
  String toString() {
    return "$_prefix$_message"; // Menggabungkan prefix dan pesan error [cite: 87, 88]
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
    : super(
        message,
        "Error During Communication: ",
      ); // Error saat komunikasi, misalnya tidak ada koneksi internet [cite: 91, 93, 94]
}

class BadRequestException extends AppException {
  BadRequestException([message])
    : super(
        message,
        "Invalid Request: ",
      ); // Error karena permintaan yang tidak valid (Status Code 400) [cite: 95, 97]
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
    : super(
        message,
        "Unauthorised: ",
      ); // Error karena tidak terautentikasi (Status Code 401 atau 403) [cite: 98, 100]
}

class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([message])
    : super(
        message,
        "Unprocessable Entity: ",
      ); // Error karena entitas tidak dapat diproses [cite: 101, 103]
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
    : super(
        message,
        "Invalid Input: ",
      ); // Error karena input tidak valid (Status Code 422) [cite: 105, 107]
}
