import 'package:flutter/material.dart';

class BotonUno extends StatelessWidget{
  const BotonUno({this.funcion,super.key, required this.texto});

  final void Function()? funcion;
  final String texto;
  @override
  Widget build(context){
    return OutlinedButton(
        onPressed: funcion,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

    );
  }
}