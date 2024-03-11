import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  // EstilistaModel? selectedEstilista; // Ya no necesitas esto

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ServiciosModel? servicio;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Me permite setear la información
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
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
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
                      } else if (!RegExp(r'^[a-zA-Z ]{3,30}$')
                          .hasMatch(value)) {
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
                        value: null, // No necesitas establecer un valor aquí
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
                                  '${estilista.nombre} ${estilista.apellido}'),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  // Show selected estilistas
                  Wrap(
                    children: selectedEstilistas.map((estilista) {
                      return Chip(
                        label:
                            Text('${estilista.nombre} ${estilista.apellido}'),
                        onDeleted: () {
                          setState(() {
                            selectedEstilistas.remove(estilista);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
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
                          Fluttertoast.showToast(
                            msg: "Actualización exitosa",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 4,
                            backgroundColor:
                                const Color.fromRGBO(116, 90, 242, 10),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
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
        ),
      ),
    );
  }
}