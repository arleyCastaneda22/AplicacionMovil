import 'package:flutter/material.dart';
import 'package:beauty_soft/pagina_inicio/paginaInicio.dart';
import 'package:beauty_soft/login_registro/login.dart';
import 'package:beauty_soft/home/home.dart';

class Init extends StatefulWidget{
  const Init({super.key});

  @override
  State<Init> createState(){
    return _InitState();
  }
}

class _InitState extends State<Init> {
  @override
  Widget? paginaActual;

  @override
  void initState() {
    paginaActual = PaginaInicio(pagina: cambioDePagina,);
    super.initState;
  }

  // init.dart > paginaInicio.dart > todas las otras paginas que actualicen
  // el componente principal
  //recibe un widget
  //en caso de ser una página con más de una redireccion se puede
  // escoger a cual de todas ir con el selector
  void cambioDePagina(Widget pagina){
    setState(() {
      paginaActual = pagina;
    });
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