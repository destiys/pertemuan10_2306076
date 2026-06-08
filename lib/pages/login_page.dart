import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // key form validator
  final _formKey = GlobalKey<FormState>();

  // controller username
  final TextEditingController usernameController =
      TextEditingController();

  // controller password
  final TextEditingController passwordController =
      TextEditingController();

  // show / hide password
  bool isHidden = true;

  // method login
  Future<void> login() async {

    // cek validasi form
    if (_formKey.currentState!.validate()) {

      final prefs = await SharedPreferences.getInstance();

      // simpan status login
      await prefs.setBool('isLogin', true);

      // simpan username
      await prefs.setString(
        'username',
        usernameController.text,
      );

      // simpan password
      await prefs.setString(
        'password',
        passwordController.text,
      );

      // pindah ke home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 5,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Form(
                key: _formKey,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.pinkAccent,
                    ),

                    const SizedBox(height: 20),

                    // INPUT USERNAME
                    TextFormField(
                      controller: usernameController,

                      decoration: InputDecoration(
                        labelText: 'Username',

                        prefixIcon:
                            const Icon(Icons.person),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),

                      validator: (value) {

                        if (value == null ||
                            value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }

                        if (value.length < 4) {
                          return 'Username minimal 4 karakter';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // INPUT PASSWORD
                    TextFormField(
                      controller: passwordController,

                      obscureText: isHidden,

                      decoration: InputDecoration(
                        labelText: 'Password',

                        prefixIcon:
                            const Icon(Icons.lock),

                        suffixIcon: IconButton(
                          icon: Icon(
                            isHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),

                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),

                      validator: (value) {

                        if (value == null ||
                            value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }

                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          "Login",

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}