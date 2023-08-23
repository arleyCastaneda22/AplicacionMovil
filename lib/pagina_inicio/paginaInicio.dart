import 'package:flutter/material.dart';
import 'package:beauty_soft/componentes_reutilizables/boton.dart';

class PaginaInicio extends StatelessWidget{
  const PaginaInicio({
    super.key,
    this.iniciarSesion,
    this.registrarse,
    this.recuperarContrasenna
  });

  final void Function()? iniciarSesion;
  final void Function()? registrarse;
  final void Function()? recuperarContrasenna;

  @override
  Widget build(context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo_beautysoft.png',
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('Beauty Soft',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonUno(texto: "Iniciar Sesión",),
              SizedBox(width: 20,),
              BotonUno(texto: "Registrarse"),
            ],
          ),
        ],
      )
    );
  }
}