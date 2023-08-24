import 'package:flutter/material.dart';

class BotonUno extends StatelessWidget{
  const BotonUno({this.funcion,super.key, required this.texto});

  final void Function()? funcion;
  final String texto;
  @override
  Widget build(context){
    return FilledButton(
        onPressed: funcion,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 106, 46, 134)),
          padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(20)),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),

    );
  }
}
