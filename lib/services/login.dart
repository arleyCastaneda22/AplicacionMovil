import 'dart:convert';
import 'package:http/http.dart' as http;

class Autenticacion {
  Future<String?> enviarDatos(String correo, String contrasena) async {
    Map<String, dynamic> datos = {'email': correo, 'contrasena': contrasena};
    try {
      var url = 'https://beautyapi-1.onrender.com/login';
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(datos),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data['token'];
      } else if (response.statusCode == 403 || response.statusCode == 400) {
        return null;
      } else {
        return 'Error login';
      }
    } catch (error) {
      return '$error';
    }
  }

  Future<void> recuperarContrasena(String email) async {
    const String apiUrl = 'https://beautyapi-1.onrender.com/forgot-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        // Éxito, el correo fue enviado correctamente
        print('Correo enviado correctamente');
        print(jsonDecode(response.body));
      } else {
        // Error en la petición
        print('Error en la petición: ${response.statusCode}');
        print(jsonDecode(response.body));
      }
    } catch (error) {
      // Error de conexión
      print('Error de conexión: $error');
    }
  }
}
