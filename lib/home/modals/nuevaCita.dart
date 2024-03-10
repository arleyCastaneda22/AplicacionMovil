import 'package:flutter/material.dart';
import 'package:beauty_soft/models/estilista.model.dart';
import '../../models/servicios.model.dart';
import '../../services/servicios.dart';

class NuevaCita extends StatefulWidget {
  @override
  State<NuevaCita> createState() {
    return _NuevaCitaState();
  }
}

class _NuevaCitaState extends State<NuevaCita> {
  final TextEditingController nombreServicio = TextEditingController();
  final TextEditingController duracion = TextEditingController();
  final TextEditingController precio = TextEditingController();
  List<ServiciosModel> servicios = [];
  List<EstilistaModel> selectedEstilistas = [];
  List<EstilistaModel> estilistas = [];
  EstilistaModel? selectedEstilista;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {});
    try {
      estilistas = await Servicios().getEstilista();
      servicios = await Servicios().getServicios();
    } catch (error) {
      throw Exception();
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreServicio,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del servicio';
                  } else if (!RegExp(r'^[a-zA-Z ]{3,30}$').hasMatch(value)) {
                    return 'El nombre del servicio debe contener solo letras y tener entre 3 y 30 caracteres';
                  }
                  return null;
                },
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
                  hintText: 'Ingrese nombre de servicio',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: duracion,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la duración del servicio';
                  }
                  return null;
                },
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
                  hintText: 'Duración(minutos)',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: precio,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el precio del servicio';
                  }
                  return null;
                },
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
                  hintText: 'Ingrese precio',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(118, 118, 118, 1),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: const Color.fromRGBO(116, 90, 242, 10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<EstilistaModel>(
                    value: selectedEstilista,
                    onChanged: (EstilistaModel? newValue) {
                      setState(() {
                        selectedEstilista = newValue;
                      });
                    },
                    items: estilistas.map<DropdownMenuItem<EstilistaModel>>(
                      (EstilistaModel estilista) {
                        return DropdownMenuItem<EstilistaModel>(
                          value: estilista,
                          child:
                              Text('${estilista.nombre} ${estilista.apellido}'),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              if (selectedEstilista == null)
                const Text(
                  'Por favor, seleccione un estilista.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // El formulario es válido, puedes realizar acciones aquí.
                    Servicios serviciosInstance = Servicios();
                    serviciosInstance
                        .enviarDatos(
                      nombreServicio.text,
                      int.parse(duracion.text),
                      int.parse(precio.text),
                      selectedEstilistas,
                    )
                        .then((result) {
                      // Actualizar la lista principal después de agregar un nuevo servicio
                      Navigator.of(context).pop();
                      setState(() {
                        _fetchData();
                      });
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
                ),
                child: const SizedBox(
                  width: 500,
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

void modalNuevaCita(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return NuevaCita();
    },
  );
}
