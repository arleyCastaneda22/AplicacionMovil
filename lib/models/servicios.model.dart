import 'dart:convert';

ServiciosModel serviciosModelFromJson(String str) => ServiciosModel.fromJson(json.decode(str));

String serviciosModelToJson(ServiciosModel data) => json.encode(data.toJson());

class ServiciosModel {
    String id;
    String nombreServicio;
    int duracion;
    int precio;
    bool estado;
    List<Estilista> estilista;
    DateTime createdAt;
    DateTime updatedAt;

    ServiciosModel({
        required this.id,
        required this.nombreServicio,
        required this.duracion,
        required this.precio,
        required this.estado,
        required this.estilista,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ServiciosModel.fromJson(Map<String, dynamic> json) => ServiciosModel(
        id: json["_id"],
        nombreServicio: json["nombre_servicio"],
        duracion: json["duracion"],
        precio: json["precio"],
        estado: json["estado"],
        estilista: List<Estilista>.from(json["estilista"].map((x) => Estilista.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre_servicio": nombreServicio,
        "duracion": duracion,
        "precio": precio,
        "estado": estado,
        "estilista": List<dynamic>.from(estilista.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Estilista {
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

  Estilista({
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

  factory Estilista.fromJson(Map<String, dynamic> json, {String? id}) => Estilista(
    id: id ?? json["_id"] ?? "default_id", // Usa id si es proporcionado, de lo contrario, usa json["_id"] o un valor predeterminado
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
