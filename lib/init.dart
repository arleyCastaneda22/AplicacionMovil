import 'package:flutter/material.dart';
import 'package:beauty_soft/pagina_inicio/paginaInicio.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() {
    return _InitState();
  }
}

class _InitState extends State<Init> {
  @override
  // ignore: override_on_non_overriding_member
  Widget? paginaActual;

  @override
  void initState() {
    paginaActual = PaginaInicio(
      pagina: cambioDePagina,
    );
    super.initState;
  }

  void cambioDePagina(Widget pagina) {
    setState(() {
      paginaActual = pagina;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: paginaActual,
        ),
      ),
    );
  }
}
