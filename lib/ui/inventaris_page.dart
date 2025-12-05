import 'package:flutter/material.dart';
import 'package:responsi2_paket1_h1d023038/bloc/logout_bloc.dart';
import 'package:responsi2_paket1_h1d023038/bloc/inventaris_bloc.dart';
import 'package:responsi2_paket1_h1d023038/model/inventaris.dart';
import 'package:responsi2_paket1_h1d023038/ui/login_page.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_detail.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_form.dart';

class InventarisPage extends StatefulWidget {
  const InventarisPage({Key? key}) : super(key: key);

  @override
  _InventarisPageState createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Komputer Ayu Fitrianingsih'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InventarisForm()),
                );
              },
            ),
          ),
        ],
      ),
      // Drawer untuk Logout (kode yang sama)
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then(
                  (value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    ),
                  },
                );
              },
            ),
          ],
        ),
      ),
      // FutureBuilder untuk menampilkan list
      body: FutureBuilder<List>(
        future: InventarisBloc.getInventarisList(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          return snapshot.hasData
              ? ListInventaris(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListInventaris extends StatelessWidget {
  final List? list;
  const ListInventaris({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemInventaris(item: list![i] as Inventaris);
      },
    );
  }
}

class ItemInventaris extends StatelessWidget {
  final Inventaris item;
  const ItemInventaris({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InventarisDetail(item: item)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(item.nama!),
          // Menampilkan harga dan jumlah di subtitle
          subtitle: Text(
            "Harga: ${item.harga.toString()} | Jumlah: ${item.jumlah.toString()}",
          ),
        ),
      ),
    );
  }
}
