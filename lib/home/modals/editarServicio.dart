import 'package:flutter/material.dart';
import '../../models/estilista.model.dart';
import '../../models/servicios.model.dart';
import '../../services/servicios.dart';
import '../home.dart';

class EditarServicio extends StatefulWidget {
  final String servicioId;
  const EditarServicio({Key? key, required this.servicioId}) : super(key: key);

  @override
  State<EditarServicio> createState() => _EditarServicioState();
}

class _EditarServicioState extends State<EditarServicio> {
  final TextEditingController nombreServicio = TextEditingController();
  final TextEditingController duracion = TextEditingController();
  final TextEditingController precio = TextEditingController();

  List<EstilistaModel> selectedEstilistas = [];
  List<EstilistaModel> estilistas = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ServiciosModel? servicio;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      estilistas = await Servicios().getEstilista();
      servicio = await Servicios().getOneServicio(widget.servicioId);

      nombreServicio.text = servicio!.nombreServicio;
      duracion.text = servicio!.duracion.toString();
      precio.text = servicio!.precio.toString();
      selectedEstilistas = servicio?.estilista.isNotEmpty == true
          ? estilistas
              .where(
                (estilista) =>
                    servicio!.estilista.any((e) => e.id == estilista.id),
              )
              .toList()
          : [];

      setState(() {});
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Editar Servicio',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(116, 90, 242, 10),
                  ),
                ),
                const SizedBox(height: 16),
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
                    labelText: 'Nombre del servicio',
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
                    labelText: 'Duración',
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
                    labelText: 'Precio',
                    hintText: 'Ingrese precio',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(118, 118, 118, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<EstilistaModel>(
                  value: null,
                  onChanged: (EstilistaModel? newValue) {
                    setState(() {
                      if (newValue != null &&
                          !selectedEstilistas.contains(newValue)) {
                        selectedEstilistas.add(newValue);
                      }
                    });
                  },
                  items: estilistas.map<DropdownMenuItem<EstilistaModel>>(
                    (EstilistaModel estilista) {
                      return DropdownMenuItem<EstilistaModel>(
                        value: estilista,
                        child: Text(
                          '${estilista.nombre} ${estilista.apellido}',
                        ),
                      );
                    },
                  ).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Estilista',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: selectedEstilistas.map((estilista) {
                    return Chip(
                      label: Text('${estilista.nombre} ${estilista.apellido}'),
                      onDeleted: () {
                        setState(() {
                          selectedEstilistas.remove(estilista);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Servicios serviciosInstance = Servicios();
                            serviciosInstance
                                .editarServicio(
                              widget.servicioId,
                              nombreServicio.text,
                              int.parse(duracion.text),
                              int.parse(precio.text),
                              selectedEstilistas,
                            )
                                .then((result) {
                              _showSuccessAlert(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(116, 90, 242, 10),
                        ),
                        child: const Text(
                          'Enviar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(116, 90, 242, 10),
                        ),
                        child: const Text(
                          'Volver',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '¡Actualización exitosa!',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromRGBO(116, 90, 242, 10),
      ),
    );
  }
}
