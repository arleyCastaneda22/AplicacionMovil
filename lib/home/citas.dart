import 'package:beauty_soft/models/citas.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/citas.dart';

class CitasAdmin extends StatefulWidget {
  const CitasAdmin({Key? key}) : super(key: key);

  @override
  State<CitasAdmin> createState() => _CitasAdminState();
}

class _CitasAdminState extends State<CitasAdmin> {
  List<CitasModel> citas = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      citas = await Citas().getCitas();
    } catch (error) {
      throw Exception();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beautysoft Citas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo_beautysoft.png'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            'Lista de Citas',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(116, 90, 242, 10),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (context, index) {
                      final cita = citas[index];
                      Color buttonColor;
                      if (cita.estado == 'confirmada') {
                        buttonColor = const Color.fromRGBO(116, 90, 242, 10);
                      } else if (cita.estado == 'finalizada') {
                        buttonColor = const Color.fromRGBO(255, 178, 43, 10);
                      } else if (cita.estado == 'pendiente') {
                        buttonColor = const Color.fromRGBO(
                            57, 139, 247, 10); // Otro color por defecto
                      } else {
                        buttonColor = const Color.fromRGBO(239, 83, 80, 10);
                      }
                      return SizedBox(
                        height: 200,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Cita con ${cita.estilista.nombre} ${cita.estilista.apellido}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(116, 90, 242, 10),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Cliente: ${cita.cliente.nombre} ${cita.cliente.apellido}'),
                                    Text(
                                        'Servicio: ${cita.servicio.nombreServicio}'),
                                    Text(
                                        'Fecha: ${DateFormat('dd/MM/yyyy').format(cita.fechaCita)}'),
                                    Text(
                                        'Hora: ${DateFormat('hh:mm a').format(cita.horaCita)}'),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        buttonColor, // Asignar el color según el estado
                                  ),
                                  child: Text(
                                    cita.estado,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
