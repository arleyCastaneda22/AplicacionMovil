import 'package:beauty_soft/home/citas.dart';
import 'package:beauty_soft/home/modals/editarServicio.dart';
import 'package:beauty_soft/login_registro/login.dart';
import 'package:flutter/material.dart';
import 'package:beauty_soft/home/modals/nuevaCita.dart';
import 'package:intl/intl.dart';
import '../componentes_reutilizables/drawer.dart';
import '../models/servicios.model.dart';
import '../services/servicios.dart';

class Home extends StatefulWidget {
  final String? correo;
  const Home({this.correo, Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<ServiciosModel> servicios = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<List<ServiciosModel>> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      servicios = await Servicios().getServicios();
      return servicios;
    } catch (error) {
      throw Exception();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openNuevaCitaModal() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NuevaCita();
      },
    );
    setState(() {});
    await _fetchData();
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
          'Beautysoft',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo_beautysoft.png'),
          ),
        ],
        backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(
        correo: widget.correo ?? "",
        onCitasPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CitasAdmin(),
            ),
          );
        },
        onServicios: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        },
        onCerrarSesionPressed: _confirmarCerrarSesion,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          const Text(
            'Lista de servicios',
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
                    itemCount: servicios.length,
                    itemBuilder: (context, index) {
                      final servicio = servicios[index];
                      String estilistasLista = "";
                      if (servicio.estilista.isNotEmpty) {
                        for (var estilista in servicio.estilista) {
                          estilistasLista +=
                              '${capitalize(estilista.nombre)} ${capitalize(estilista.apellido)}, ';
                        }
                        estilistasLista = estilistasLista.substring(
                            0, estilistasLista.length - 2);
                      } else {
                        estilistasLista = "Sin estilistas asignados";
                      }
                      String nombreServicioCapitalizado =
                          capitalize(servicio.nombreServicio);
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
                                  nombreServicioCapitalizado,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(116, 90, 242, 10),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estilistas: $estilistasLista'),
                                    Text(
                                        'Duración: ${servicio.duracion} minutos'),
                                    Text(
                                      'Precio:  ${NumberFormat.currency(
                                        locale: 'es',
                                        decimalDigits: 0,
                                        symbol: '\$',
                                      ).format(servicio.precio)}',
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        final scaffoldMessenger =
                                            ScaffoldMessenger.of(context);
                                        Servicios serviciosInstance =
                                            Servicios();

                                        String resultado =
                                            await serviciosInstance
                                                .actualizarEstado(servicio.id);

                                        if (resultado.contains(
                                            'Error: El servicio tiene citas asociadas')) {
                                          scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Error: No se puede cambiar el estado. El servicio tiene citas asociadas.',
                                              ),
                                              backgroundColor: Color.fromRGBO(
                                                  116, 90, 242, 10),
                                            ),
                                          );
                                        } else {
                                          scaffoldMessenger.showSnackBar(
                                            SnackBar(
                                              content: Text(resultado),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      116, 90, 242, 10),
                                            ),
                                          );
                                          setState(() {
                                            _fetchData(); // Recargar los datos después de cambiar el estado
                                          });
                                        }
                                      } catch (error) {
                                        throw Exception();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      backgroundColor: servicio.estado
                                          ? const Color.fromRGBO(
                                              116, 90, 242, 10)
                                          : Colors.black,
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          servicio.estado
                                              ? 'Activo'
                                              : 'Inactivo',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Visibility(
                                    visible: servicio.estado,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Servicios intancia = Servicios();
                                        intancia
                                            .getOneServicio(servicio.id)
                                            .then((value) =>
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditarServicio(
                                                            servicioId:
                                                                servicio.id),
                                                  ),
                                                ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            6, 215, 156, 10),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size:
                                                24.0, // Ajusta el tamaño del ícono
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Editar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  //modal nueva cita
                  _openNuevaCitaModal();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
                ),
                child: const Text(
                  "Agregar servicio",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String capitalize(String input) {
  return input.isNotEmpty
      ? '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}'
      : input;
}
