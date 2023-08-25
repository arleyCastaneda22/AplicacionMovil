import 'package:flutter/material.dart';
import 'package:beauty_soft/home/modals/nuevaCita.dart';

/*class Home extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF6A2E86), // Cambia el color de la AppBar
        accentColor: Color(0xFF6A2E86), // Cambia el color de los botones y otros acentos
      ),
      home: MyHomePage(),
    );
  }
}*/

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState(){
    return _HomeState();
  }

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Citas"),
        backgroundColor: Color(0xFF6A2E86), // Cambia el color de la AppBar
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Nombre de Usuario"),
              accountEmail: Text("usuario@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.jpg'), // cambiar con la ruta de tu imagen del perfil
              ),
              decoration: BoxDecoration(
                color: Color(0xFF6A2E86), // Cambia el color del Drawer
              ),
            ),
            ListTile(
              title: Text("Mi Perfil"),
              leading: Icon(Icons.person),
              onTap: () {
                // modal para cambiar "Mi Perfil" aquí--------
              },
            ),
            ListTile(
              title: Text("Cerrar Sesión"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                // sacar el modal de deseas "Cerrar Sesión" aquí----------
              },
            ),
            Spacer(),
            ListTile(
              title: Text("Configuración"),
              leading: Icon(Icons.settings),
              onTap: () {
                // contenido o accion del boton de Configuración aquí
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Número de citas
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Cita $index"),
                    subtitle: Text("Fecha y hora de la cita"),
                    // contenido de las cards aca-------------------
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
                  primary: Color(0xFF6A2E86), // Cambia el color del botón
                ),
                child: Text("Nueva Cita"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
