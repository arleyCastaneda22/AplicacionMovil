import 'dart:convert';

import 'package:beauty_soft/models/citas.model.dart';
import 'package:http/http.dart' as http;

class Citas {
  Future<List<CitasModel>> getCitas() async {
    try {
      var url = Uri.https('beautyapi-1.onrender.com', '/api/citas');
      final response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      List<CitasModel> citas =
          data.map((servicios) => CitasModel.fromJson(servicios)).toList();
      if (response.statusCode == 200) {
        return citas;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud HTTP: $error');
    }
  }

  Future<List<CitasModel>> getCitasPorEstilistaId(String estilistaId) async {
    try {
      var url = Uri.https(
          'beautyapi-1.onrender.com', '/api/citas/$estilistaId/citas');
      final response = await http.get(url);

      List<dynamic> data = jsonDecode(response.body);
      List<CitasModel> citas =
          data.map((servicios) => CitasModel.fromJson(servicios)).toList();
      if (response.statusCode == 200) {
        return citas;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      // Si ocurre un error durante la solicitud, devuelve null
      throw Exception('Error durante la solicitud HTTP: $error');
    }
  }
}
