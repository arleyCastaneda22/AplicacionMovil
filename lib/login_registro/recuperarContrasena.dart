import 'package:beauty_soft/home/home.dart';
import 'package:beauty_soft/login_registro/login.dart';
import 'package:flutter/material.dart';

class Recuperar extends StatefulWidget {
  const Recuperar({super.key});

  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {
   final TextEditingController correo = TextEditingController();
   final _formKey =
      GlobalKey<FormState>(); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Scaffold(body: SingleChildScrollView(
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
                        'Recuperar contraseña',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(116, 90, 242, 10),
                            ),
                            child: const Text(
                              'Enviar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                         SizedBox(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                                  Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(116, 90, 242, 10),
                            ),
                            child: const Text(
                              'Volver',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
             
                ],
              ),
            ),
          ),
        ],
      ),
    ))
,) ;
  }
}