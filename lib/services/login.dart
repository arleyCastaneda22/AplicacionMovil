import 'dart:convert';
import 'package:http/http.dart' as http;

class Autenticacion {
  Future<String?> enviarDatos(String correo, String contrasena) async {
    Map<String, dynamic> datos = {'email': correo, 'contrasena': contrasena};
    try {
      var url = 'http://localhost:5000/login';
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
}
