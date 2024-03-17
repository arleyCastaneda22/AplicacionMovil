import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../login_registro/login.dart';
import '../models/citas.model.dart';
import '../services/citas.dart';

class Estilistas extends StatefulWidget {
  final String estilistaId;
  const Estilistas({required this.estilistaId, Key? key}) : super(key: key);

  @override
  State<Estilistas> createState() => _EstilistasState();
}

class _EstilistasState extends State<Estilistas> {
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
      citas = await Citas().getCitasPorEstilistaId(widget.estilistaId);
      citas.sort((a, b) {
        // Primero, comparamos las fechas
        final dateComparison = a.fechaCita.compareTo(b.fechaCita);
        if (dateComparison != 0) {
          return dateComparison;
        }
        // Si las fechas son iguales, comparamos las horas
        return a.horaCita.compareTo(b.horaCita);
      });
    } catch (error) {
      throw Exception();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmarCerrarSesion() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Cierre de Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el modal
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
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
              child: IconButton(
                icon: const Icon(Icons.power_settings_new),
                onPressed: _confirmarCerrarSesion,
              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
        ));
  }
}
