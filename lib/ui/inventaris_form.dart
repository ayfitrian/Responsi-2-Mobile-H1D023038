import 'package:flutter/material.dart';
import 'package:responsi2_paket1_h1d023038/bloc/inventaris_bloc.dart';
import 'package:responsi2_paket1_h1d023038/model/inventaris.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_page.dart';
import 'package:responsi2_paket1_h1d023038/widget/warning_dialog.dart';

// ignore: must_be_immutable
class InventarisForm extends StatefulWidget {
  Inventaris? item;
  InventarisForm({Key? key, this.item}) : super(key: key);

  @override
  _InventarisFormState createState() => _InventarisFormState();
}

class _InventarisFormState extends State<InventarisForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH INVENTARIS";
  String tombolSubmit = "SIMPAN";

  // Controllers
  final _namaTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();

  // ... (initState dan isUpdate disesuaikan untuk 4 field baru)
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.item != null) {
      setState(() {
        judul = "UBAH INVENTARIS";
        tombolSubmit = "UBAH";
        _namaTextboxController.text = widget.item!.nama!;
        _hargaTextboxController.text = widget.item!.harga.toString();
        _jumlahTextboxController.text = widget.item!.jumlah.toString();
        _tanggalMasukTextboxController.text = widget.item!.tanggalMasuk!;
      });
    } else {
      judul = "TAMBAH INVENTARIS";
      tombolSubmit = "SIMPAN";
    }
  }
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$judul Ayu Fitrianingsih')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _hargaTextField(),
                _jumlahTextField(),
                _tanggalMasukTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget Text Fields baru ---
  Widget _namaTextField() {
    /* ... */
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Barang"),
      controller: _namaTextboxController,
      validator: (value) => value!.isEmpty ? "Nama Barang harus diisi" : null,
    );
  }

  Widget _hargaTextField() {
    /* ... */
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) => value!.isEmpty ? "Harga harus diisi" : null,
    );
  }

  Widget _jumlahTextField() {
    /* ... */
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) => value!.isEmpty ? "Jumlah harus diisi" : null,
    );
  }

  Widget _tanggalMasukTextField() {
    /* ... */
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Tanggal Masuk (YYYY-MM-DD)",
      ),
      controller: _tanggalMasukTextboxController,
      validator: (value) => value!.isEmpty ? "Tanggal Masuk harus diisi" : null,
    );
  }
  // --- Akhir Widget Text Fields baru ---

  // --- Widget Button Submit ---
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) {
          widget.item != null ? ubah() : simpan();
        }
      },
    );
  }
  // --- Akhir Button Submit ---

  // --- Fungsi Simpan dan Ubah ---
  simpan() {
    setState(() => _isLoading = true);
    Inventaris createItem = Inventaris(
      nama: _namaTextboxController.text,
      harga: int.parse(_hargaTextboxController.text),
      jumlah: int.parse(_jumlahTextboxController.text),
      tanggalMasuk: _tanggalMasukTextboxController.text,
    );
    InventarisBloc.addInventaris(item: createItem).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const InventarisPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              const WarningDialog(description: "Simpan gagal"),
        );
      },
    );
    setState(() => _isLoading = false);
  }

  ubah() {
    setState(() => _isLoading = true);
    Inventaris updateItem = Inventaris(
      id: widget.item!.id!,
      nama: _namaTextboxController.text,
      harga: int.parse(_hargaTextboxController.text),
      jumlah: int.parse(_jumlahTextboxController.text),
      tanggalMasuk: _tanggalMasukTextboxController.text,
    );
    InventarisBloc.updateInventaris(item: updateItem).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const InventarisPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              const WarningDialog(description: "Ubah data gagal"),
        );
      },
    );
    setState(() => _isLoading = false);
  }

  // --- Akhir Fungsi Simpan dan Ubah ---
}
