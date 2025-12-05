import 'dart:convert';
import 'package:responsi2_paket1_h1d023038/helpers/api.dart';
import 'package:responsi2_paket1_h1d023038/helpers/api_url.dart';
import 'package:responsi2_paket1_h1d023038/model/inventaris.dart';

class InventarisBloc {
  // READ ALL
  static Future<List<Inventaris>> getInventarisList() async {
    String apiUrl = ApiUrl.listInventaris;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);

    List<dynamic> listData = (jsonObj as Map<String, dynamic>)['data'];
    List<Inventaris> items = [];

    for (int i = 0; i < listData.length; i++) {
      items.add(Inventaris.fromJson(listData[i]));
    }
    return items;
  }

  // CREATE
  static Future addInventaris({Inventaris? item}) async {
    String apiUrl = ApiUrl.createInventaris;
    var body = {
      "nama": item!.nama,
      "harga": item.harga.toString(),
      "jumlah": item.jumlah.toString(),
      "tanggal_masuk": item.tanggalMasuk,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // UPDATE
  static Future updateInventaris({required Inventaris item}) async {
    String apiUrl = ApiUrl.updateInventaris(int.parse(item.id!));

    var body = {
      "nama": item.nama,
      "harga": item.harga.toString(),
      "jumlah": item.jumlah.toString(),
      "tanggal_masuk": item.tanggalMasuk,
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // DELETE
  static Future<bool> deleteInventaris({int? id}) async {
    String apiUrl = ApiUrl.deleteInventaris(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] ?? false;
  }
}
