import 'dart:convert';

Parking parkingFromJson(String str) => Parking.fromJson(json.decode(str));

String parkingToJson(Parking data) => json.encode(data.toJson());

class Parking {
  Parking(
      {this.siteName = "",
      this.active = false,
      this.id = "",
      this.idCars = ""});

  String idCars;
  String siteName;
  bool active;
  String id;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        siteName: json["siteName"] == null ? "" : json["siteName"],
        active: json["active"] == null ? false : json["active"],
        id: json["id"] == null ? "" : json["id"],
        idCars: json["idCars"] == null ? "" : json["idCars"],
      );

  Map<String, dynamic> toJson() =>
      {"siteName": siteName, "active": active, "id": id, "idCars": idCars};
}
