import 'package:beauty_soft/home/home.dart';
import 'package:beauty_soft/login_registro/recuperarContrasena.dart';
import 'package:beauty_soft/services/login.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final void Function(Widget pagina)? cambiarPagina;

  const Login({this.cambiarPagina, Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasena = TextEditingController();
  final _formKey =
      GlobalKey<FormState>(); // Añadido un GlobalKey para el formulario

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(60)),
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
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(120)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Form(
            key: _formKey, // Asignado el GlobalKey al formulario
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
                        // Puedes agregar una validación de formato de correo electrónico aquí si es necesario
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
                                  String? token =
                                      await instanciaLogin.enviarDatos(
                                          correo.text, contrasena.text);

                                  if (token != null) {
                                    // Autenticación exitosa, navegar a la pantalla Home
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Home(),
                                      ),
                                    );
                                  } else {
                                    // Manejar el error en la interfaz de usuario o imprimir un mensaje
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Credenciales inválidas'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
    );
  }
}
