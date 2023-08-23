import 'package:flutter/material.dart';
import 'package:beauty_soft/pagina_inicio/paginaInicio.dart';

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
    paginaActual = PaginaInicio();
    super.initState;
  }

  @override
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 106, 46, 134),
                  Color.fromARGB(255, 197, 97, 69),
                ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: paginaActual,
        ),
      ),
    );
  }
}