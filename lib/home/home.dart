import 'package:flutter/material.dart';
import 'package:beauty_soft/home/modals/nuevaCita.dart';

import '../services/servicios.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

@override
void initState() {}

class _HomeState extends State<Home> {
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
            child: Image.asset(
                'assets/images/logo_beautysoft.png'), // Ajusta la ruta de la imagen según tu proyecto
          ),
        ],
        backgroundColor: const Color.fromRGBO(
            116, 90, 242, 10), // Cambia el color de la AppBar
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Nombre de Usuario"),
              accountEmail: Text("usuario@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // cambiar con la ruta de tu imagen del perfil
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(
                    116, 90, 242, 10), // Cambia el color del Drawer
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
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Número de citas
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 150,
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
                          title: Text(
                            "Nombre de servicio $index",
                            textAlign: TextAlign.center,
                          ),
                          subtitle: const Text("30 minutos"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Lógica del primer botón
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Editar",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Lógica del segundo botón
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .white, // Cambia el color del botón según tu preferencia
                              ),
                              child: const Text(
                                "Estado",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
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
                  Servicios().getServicios();
                  modalNuevaCita(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(
                      116, 90, 242, 10), // Cambia el color del botón
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
