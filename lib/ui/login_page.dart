import 'package:flutter/material.dart';
import 'package:responsi2_paket1_h1d023038/bloc/login_bloc.dart';
import 'package:responsi2_paket1_h1d023038/helpers/user_info.dart';
import 'package:responsi2_paket1_h1d023038/ui/inventaris_page.dart';
import 'package:responsi2_paket1_h1d023038/ui/registrasi_page.dart';
import 'package:responsi2_paket1_h1d023038/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Ayu Fitrianingsih')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget Text Fields ---
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }
  // --- Akhir Widget Text Fields ---

  Widget _buttonLogin() {
    return ElevatedButton(
      child: const Text("Login"),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then(
      (value) async {
        if (value.code == 200) {
          // Login berhasil: Simpan token dan ID
          await UserInfo().setToken(value.token.toString());
          await UserInfo().setUserID(int.parse(value.userID.toString()));

          // Pindah ke halaman InventarisPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InventarisPage()),
          );
        } else {
          // Jika kode bukan 200 (error dari API), tampilkan warning
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => WarningDialog(
              description: value.message ?? "Login gagal, silahkan coba lagi",
            ),
          );
        }
      },
      onError: (error) {
        // Error Jaringan/Server (exception dilempar)
        print(error);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description:
                "Terjadi kesalahan jaringan atau server, coba lagi nanti.",
          ),
        );
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text("Registrasi", style: TextStyle(color: Colors.blue)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
