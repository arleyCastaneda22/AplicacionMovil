import 'package:flutter/material.dart';
import 'package:beauty_soft/home/modals/nuevaCita.dart';
import '../models/servicios.model.dart';
import '../services/servicios.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beautysoft',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo_beautysoft.png'),
          ),
        ],
        backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Nombre de Usuario"),
              accountEmail: Text("usuario@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(116, 90, 242, 10),
              ),
            ),
            ListTile(
              title: const Text("Mi Perfil"),
              leading: const Icon(Icons.person),
              onTap: () {
                // modal para cambiar "Mi Perfil" aquí--------
              },
            ),
            ListTile(
              title: const Text("Cerrar Sesión"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                // sacar el modal de deseas "Cerrar Sesión" aquí----------
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text("Configuración"),
              leading: const Icon(Icons.settings),
              onTap: () {
                // contenido o acción del botón de Configuración aquí
              },
            ),
          ],
        ),
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
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(nombreServicioCapitalizado),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estilistas: $estilistasLista'),
                                    Text(
                                        'Duración: ${servicio.duracion} minutos'),
                                    Text('Precio: COP ${servicio.precio}'),
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
                                                  'Error: No se puede cambiar el estado. El servicio tiene citas asociadas.'),
                                            ),
                                          );
                                        } else {
                                          scaffoldMessenger.showSnackBar(
                                            SnackBar(
                                              content: Text(resultado),
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
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            6, 215, 156, 10),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
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
                  modalNuevaCita(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(116, 90, 242, 10),
                ),
                child: const Text("Agregar servicio"),
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
