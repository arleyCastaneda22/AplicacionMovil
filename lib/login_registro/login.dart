import 'package:flutter/material.dart';
import 'package:beauty_soft/home/citas.dart';
import 'package:beauty_soft/home/citasEstilista.dart';
import 'package:beauty_soft/login_registro/recuperarContrasena.dart';
import 'package:beauty_soft/services/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BeautySoft',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  final void Function(Widget pagina)? cambiarPagina;

  const Login({this.cambiarPagina, Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController correo;
  late TextEditingController contrasena;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    correo = TextEditingController();
    contrasena = TextEditingController();
  }

  @override
  void dispose() {
    correo.dispose();
    contrasena.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(60)),
                          color: Color.fromRGBO(116, 90, 242, 10),
                        ),
                        child: const Center(
                          child: Text(
                            'BeautySoft',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(116, 90, 242, 10),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(120)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextFormField(
                          controller: correo,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(116, 90, 242, 10),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(116, 90, 242, 10),
                              ),
                            ),
                            hintText: 'Ingrese correo electrónico',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(118, 118, 118, 1),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese su correo electrónico';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextFormField(
                          controller: contrasena,
                          obscureText: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(116, 90, 242, 10),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(116, 90, 242, 10),
                              ),
                            ),
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(118, 118, 118, 1),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese su contraseña';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      Autenticacion instanciaLogin =
                                          Autenticacion();

                                      Map<String, dynamic>? result =
                                          await instanciaLogin.enviarDatos(
                                              correo.text, contrasena.text);
                                      if (result != null) {
                                        String id = result['id'];
                                        List<String>? roles = result['roles'];

                                        if (roles != null) {
                                          if (roles.contains('admin')) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CitasAdmin(
                                                        correo: correo.text),
                                              ),
                                            );
                                          } else if (roles
                                              .contains('estilista')) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Estilistas(
                                                  estilistaId: id,
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Credenciales inválidas'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Credenciales inválidas'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Error de autenticación. Por favor, inténtalo de nuevo.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(116, 90, 242, 10),
                                ),
                                child: const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Recuperar()),
                                );
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    color: Color.fromRGBO(116, 90, 242, 10)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
