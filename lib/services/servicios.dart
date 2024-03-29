import 'dart:convert';

import 'package:beauty_soft/models/estilista.model.dart';
import 'package:http/http.dart' as http;
import '../models/servicios.model.dart';

class Servicios {
  Future<List<ServiciosModel>> getServicios() async {
    try {
      var url = Uri.https('beautyapi-1.onrender.com', '/api/servicios');
      final response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      List<ServiciosModel> servicio =
          data.map((servicios) => ServiciosModel.fromJson(servicios)).toList();
      if (response.statusCode == 200) {
        return servicio;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud HTTP: $error');
    }
  }

  Future<List<EstilistaModel>> getEstilista() async {
    try {
      var url = Uri.https('beautyapi-1.onrender.com', '/api/estilistas');
      final response = await http.get(url);
      List<dynamic> data = jsonDecode(response.body);
      List<EstilistaModel> estilista =
          data.map((servicios) => EstilistaModel.fromJson(servicios)).toList();
      if (response.statusCode == 200) {
        return estilista;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error durante la solicitud HTTP: $error');
    }
  }

  Future<String> actualizarEstado(String id) async {
    try {
      var url =
          Uri.https('beautyapi-1.onrender.com', '/api/servicios/estado/$id');
      final response = await http.get(url);

      if (response.statusCode == 204) {
        return 'Estado actualizado con éxito';
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['message'] ?? 'Error 400: Error desconocido';

        return errorMessage;
      } else {
        return 'Error al actualizar el estado. Código: ${response.statusCode}';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }

  Future<bool> enviarDatos(String nombreservicio, int duracion, int precio,
      List<EstilistaModel> estilistas) async {
    List<String> idEstilistas = estilistas.map((e) => e.id).toList();
    Map<String, dynamic> datos = {
      'nombre_servicio': nombreservicio,
      'duracion': duracion,
      'precio': precio,
      'estilista': idEstilistas
    };

    try {
      var url = 'https://beautyapi-1.onrender.com/api/servicios/';
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(datos),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('entró');
        return true;
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['message'] ?? 'Error 400: Error desconocido';

        return errorMessage;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<ServiciosModel> getOneServicio(String id) async {
    try {
      var url = Uri.parse("https://beautyapi-1.onrender.com/api/servicios/$id");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        ServiciosModel servicio = ServiciosModel.fromJson(data);
        return servicio;
      } else {
        throw Exception(
            'Error durante la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editarServicio(String id, String nombreservicio, int duracion,
      int precio, List<EstilistaModel> estilistas) async {
    try {
      var url = 'https://beautyapi-1.onrender.com/api/servicios/$id';
      List<String> idEstilistas = estilistas.map((e) => e.id).toList();
      Map<String, dynamic> datos = {
        'nombre_servicio': nombreservicio,
        'duracion': duracion,
        'precio': precio,
        'estilista': idEstilistas
      };

      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(datos),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['message'] ?? 'Error 400: Error desconocido';

        return errorMessage;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
