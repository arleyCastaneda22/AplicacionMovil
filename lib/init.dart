import 'package:flutter/material.dart';
import 'package:beauty_soft/pagina_inicio/paginaInicio.dart';
import 'package:beauty_soft/login_registro/login.dart';

class Init extends StatefulWidget{
  const Init({super.key});

  @override
  State<Init> createState(){
    return _InitState();
  }
}

class _InitState extends State<Init> {  @override

  Widget? paginaActual;

  @override
  void initState() {
    paginaActual = PaginaInicio(iniciarSesion: goToLogin,);
    super.initState;
  }

  void goToLogin(){
    setState(() {
      paginaActual = Login();
    });
    print("Clickeando!");
  }

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: paginaActual,
        ),
      ),
    );
  }
}