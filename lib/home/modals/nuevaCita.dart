import 'package:flutter/material.dart';

class NuevaCita extends StatefulWidget {
  @override
  State<NuevaCita> createState() {
    return _NuevaCitaState();
  }
}

class _NuevaCitaState extends State<NuevaCita> {
  // Controladores para los campos del formulario
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();

  // Opciones para el campo de selección
  List<String> opciones = ['Andrea', 'Corte dama'];
  String selectedOption = 'Andrea';

  @override
  void dispose() {
    fechaController.dispose();
    horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  hintText: 'Ingrese nombre de servicio',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  hintText: 'Duración(minutos)',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(116, 90, 242, 10)),
                  ),
                  hintText: 'Ingrese precio',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Campo de selección personalizado
              Container(
                width: double.infinity, // Ancho máximo posible
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: const Color.fromRGBO(116, 90, 242, 10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    items:
                        opciones.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción del botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(
                      116, 90, 242, 10), // Cambia el color del botón
                ),
                child: const SizedBox(
                  width: 500, // Ancho deseado del botón
                  child: Center(
                    child: Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void modalNuevaCita(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return NuevaCita();
    },
  );
}
