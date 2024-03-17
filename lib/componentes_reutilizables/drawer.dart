import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String? correo;
  final VoidCallback? onCitasPressed;
  final VoidCallback? onServicios;
  final VoidCallback onCerrarSesionPressed;

  const CustomDrawer({
    this.correo,
    this.onCitasPressed,
    this.onServicios,
    required this.onCerrarSesionPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Administrador"),
            accountEmail: Text(correo!),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/usuarioss.png'),
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(116, 90, 242, 10),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text("Citas"),
                  leading: const Icon(Icons.event),
                  onTap: onCitasPressed,
                ),
                ListTile(
                  title: const Text("Servicios"),
                  leading: const Icon(Icons.local_offer),
                  onTap: onServicios,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Cerrar Sesión"),
            leading: const Icon(Icons.exit_to_app),
            onTap: onCerrarSesionPressed,
          ),
        ],
      ),
    );
  }
}
