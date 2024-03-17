import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class Autenticacion {
  Future<Map<String, dynamic>?> enviarDatos(
      String correo, String contrasena) async {
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
        String token = data['token'];
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
        List<dynamic>? roles = decodedToken['roles'];
        String? id = decodedToken['_id'];

        // Verificar si roles es null o no está definido
        if (roles == null || id == null) {
          return null;
        }

        // Convertir roles a una lista de cadenas
        List<String> roleNames = roles.map((role) => role.toString()).toList();
        return {'roles': roleNames, 'id': id};
      } else if (response.statusCode == 403 || response.statusCode == 400) {
        return null;
      } else {
        return {'error': 'Error login'};
      }
    } catch (error) {
      return {'error': '$error'};
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

        jsonDecode(response.body);
      } else {
        // Error en la petición

        jsonDecode(response.body);
      }
    } catch (error) {
      // Error de conexión
    }
  }
}
