import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/servicios.model.dart';

class Servicios {
  Future<List<ServiciosModel>> getServicios() async {
    try {
      var url = Uri.http('localhost:5000', '/api/servicios');
      final response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      List<ServiciosModel> servicio =
          data.map((obra) => ServiciosModel.fromJson(obra)).toList();
      if (response.statusCode == 200) {
        print(data);
        return servicio;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud HTTP: $error');
    }
  }
}
