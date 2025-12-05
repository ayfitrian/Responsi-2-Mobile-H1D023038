import 'package:flutter/material.dart';
import 'package:responsi2_paket1_h1d023038/helpers/user_info.dart';
import 'package:responsi2_paket1_h1d023038/ui/login_page.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_page.dart'; // Nama page baru

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const InventarisPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // KETENTUAN 1: Nama Aplikasi + NIM
      title: 'Responsi 2 Mobile Paket 1 (H1D023038)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // KETENTUAN 2: Warna Abu-abu (menggunakan BlueGrey untuk shading)
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ).copyWith(primary: Colors.blueGrey[700]),
        useMaterial3: false,
      ),
      home: page,
    );
  }
}
