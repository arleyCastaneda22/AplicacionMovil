// To parse this JSON data, do
//
//     final citasModel = citasModelFromJson(jsonString);

import 'dart:convert';

List<CitasModel> citasModelFromJson(String str) => List<CitasModel>.from(json.decode(str).map((x) => CitasModel.fromJson(x)));

String citasModelToJson(List<CitasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitasModel {
    String id;
    Cliente cliente;
    Servicio servicio;
    Cliente estilista;
    DateTime fechaCita;
    DateTime horaCita;
    DateTime horaFinCita;
    String estado;
    String turno;
    DateTime createdAt;
    DateTime updatedAt;

    CitasModel({
        required this.id,
        required this.cliente,
        required this.servicio,
        required this.estilista,
        required this.fechaCita,
        required this.horaCita,
        required this.horaFinCita,
        required this.estado,
        required this.turno,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CitasModel.fromJson(Map<String, dynamic> json) => CitasModel(
        id: json["_id"],
        cliente: Cliente.fromJson(json["cliente"]),
        servicio: Servicio.fromJson(json["servicio"]),
        estilista: Cliente.fromJson(json["estilista"]),
        fechaCita: DateTime.parse(json["fechaCita"]),
        horaCita: DateTime.parse(json["horaCita"]),
        horaFinCita: DateTime.parse(json["horaFinCita"]),
        estado: json["estado"],
        turno: json["turno"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cliente": cliente.toJson(),
        "servicio": servicio.toJson(),
        "estilista": estilista.toJson(),
        "fechaCita": fechaCita.toIso8601String(),
        "horaCita": horaCita.toIso8601String(),
        "horaFinCita": horaFinCita.toIso8601String(),
        "estado": estado,
        "turno": turno,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Cliente {
    String id;
    String email;
    String nombre;
    String apellido;
    String contrasena;
    String telefono;
    String? direccion;
    List<String> roles;
    bool estado;
    DateTime createdAt;
    DateTime updatedAt;
    int? v;

    Cliente({
        required this.id,
        required this.email,
        required this.nombre,
        required this.apellido,
        required this.contrasena,
        required this.telefono,
        this.direccion,
        required this.roles,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        this.v,
    });

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["_id"],
        email: json["email"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        contrasena: json["contrasena"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "nombre": nombre,
        "apellido": apellido,
        "contrasena": contrasena,
        "telefono": telefono,
        "direccion": direccion,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Servicio {
    String id;
    String nombreServicio;
    int duracion;
    int precio;
    bool estado;
    List<String> estilista;
    DateTime createdAt;
    DateTime updatedAt;

    Servicio({
        required this.id,
        required this.nombreServicio,
        required this.duracion,
        required this.precio,
        required this.estado,
        required this.estilista,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["_id"],
        nombreServicio: json["nombre_servicio"],
        duracion: json["duracion"],
        precio: json["precio"],
        estado: json["estado"],
        estilista: List<String>.from(json["estilista"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre_servicio": nombreServicio,
        "duracion": duracion,
        "precio": precio,
        "estado": estado,
        "estilista": List<dynamic>.from(estilista.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
