import 'package:flutter/material.dart';
import 'package:responsi2_paket1_h1d023038/bloc/inventaris_bloc.dart';
import 'package:responsi2_paket1_h1d023038/model/inventaris.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_form.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_page.dart';
import 'package:responsi2_paket1_h1d023038/widget/warning_dialog.dart';
import 'package:responsi2_paket1_h1d023038/widget/success_dialog.dart';

// ignore: must_be_immutable
class InventarisDetail extends StatefulWidget {
  Inventaris? item;
  InventarisDetail({Key? key, this.item}) : super(key: key);

  @override
  _InventarisDetailState createState() => _InventarisDetailState();
}

class _InventarisDetailState extends State<InventarisDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Inventaris Komputer Ayu Fitrianingsih'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${widget.item!.nama}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Harga: Rp. ${widget.item!.harga.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Jumlah: ${widget.item!.jumlah.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Tanggal Masuk: ${widget.item!.tanggalMasuk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  // ... (Fungsi _tombolHapusEdit dan confirmHapus yang dimodifikasi untuk InventarisBloc)
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InventarisForm(item: widget.item!),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            Navigator.pop(context);
            InventarisBloc.deleteInventaris(
              id: int.parse(widget.item!.id!),
            ).then(
              (value) {
                if (value == true) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => SuccessDialog(
                      description: "Hapus inventaris berhasil!",
                      okClick: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const InventarisPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const WarningDialog(description: "Hapus gagal."),
                  );
                }
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, ada masalah koneksi/server.",
                  ),
                );
              },
            );
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
