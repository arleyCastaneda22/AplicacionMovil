import 'package:flutter/material.dart';
import 'package:beauty_soft/componentes_reutilizables/boton.dart';

class Login extends StatelessWidget {
  final void Function(Widget pagina)? cambiarPagina;

  const Login({this.cambiarPagina ,super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              child: Column(children: [
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
                              color: Colors.purple),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          decoration: const BoxDecoration(color: Colors.purple),
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
                  child: Container(
                    width: 250,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(164, 119, 90, 1))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(164, 119, 90, 1))),
                                hintText: 'Email o número de teléfono',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(118, 118, 118, 1)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(164, 119, 90, 1))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(164, 119, 90, 1))),
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(118, 118, 118, 1)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 250,
                              height: 40,
                              child: BotonDos(texto: "Login", funcion: cambiarPagina,),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    color: Color.fromRGBO(106, 46, 134, 1)))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Registrarse',
                              style:
                              TextStyle(color: Color.fromRGBO(106, 46, 134, 1)),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                )
              ]));
  }
}