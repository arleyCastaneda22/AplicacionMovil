import 'dart:convert';

EstilistaModel estilistaModelFromJson(String str) => EstilistaModel.fromJson(json.decode(str));

String estilistaModelToJson(EstilistaModel data) => json.encode(data.toJson());

class EstilistaModel {
    String id;
    String nombre;
    String apellido;
    String telefono;
    String email;
    String contrasena;
    List<String> roles;
    bool estado;
    DateTime createdAt;
    DateTime updatedAt;

    EstilistaModel({
        required this.id,
        required this.nombre,
        required this.apellido,
        required this.telefono,
        required this.email,
        required this.contrasena,
        required this.roles,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
    });

    factory EstilistaModel.fromJson(Map<String, dynamic> json) => EstilistaModel(
        id: json["_id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        email: json["email"],
        contrasena: json["contrasena"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "email": email,
        "contrasena": contrasena,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}