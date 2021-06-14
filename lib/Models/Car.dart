import 'dart:convert';
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Models/Parking.dart';

Cars carsFromJson(String str) => Cars.fromJson(json.decode(str));

String carsToJson(Cars data) => json.encode(data.toJson());

class Cars {
  Cars({
    this.enrollment = "",
    this.driver,
    this.timeStart = "",
    this.dateTimeStart = "",
    this.dateTimeEnd = "",
    this.timeEnd = "",
    this.active = false,
    this.id = "",
    this.timeElapsed = "",
    this.valueParking = "0.0",
    this.pennies = 0,
    this.dolar = 0,
    this.minElapsed = "",
    this.hourElapsed = "",
    this.site,
    this.cacheImage = "",
  });

  String cacheImage;
  Parking? site;
  String timeElapsed;
  String valueParking;
  String id;
  String enrollment;
  Driver? driver;
  String timeStart;
  String timeEnd;
  String dateTimeEnd;
  String dateTimeStart;
  bool active;
  String hourElapsed;
  String minElapsed;
  int dolar;
  int pennies;

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
        cacheImage: json["cacheImage"] == null ?"": json["cacheImage"],
        minElapsed: json["minElapsed"] == null ? "0" : json["minElapsed"],
        hourElapsed: json["hourElapsed"] == null ? "0" : json["hourElapsed"],
        dolar: json["dolar"] == null ? 0 : json["dolar"],
        pennies: json["pennies"] == null ? 0 : json["pennies"],
        valueParking:
            json["valueParking"] == null ? "0.0" : json["valueParking"],
        timeElapsed: json["timeRemaining"] == null ? "" : json["timeRemaining"],
        id: json["id"] == null ? "" : json["id"],
        enrollment: json["enrollment"] == null ? "" : json["enrollment"],
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        timeStart: json["timeStart"] == null ? "" : json["timeStart"],
        timeEnd: json["timeEnd"] == null ? "" : json["timeEnd"],
        dateTimeStart:
            json["dateTimeStart"] == null ? "" : json["dateTimeStart"],
        dateTimeEnd: json["dateTimeEnd"] == null ? "" : json["dateTimeEnd"],
        active: json["active"] == null ? false : json["active"],
        site: json["site"] == null ? null : Parking.fromJson(json["site"]),
      );

  Map<String, dynamic> toJson() => {
    "cacheImage":cacheImage,
        "site": site?.toJson(),
        "minElapsed": minElapsed,
        "hourElapsed": hourElapsed,
        "dolar": dolar,
        "pennies": pennies,
        "valueParking": valueParking,
        "timeRemaining": timeElapsed,
        "id": id,
        "enrollment": enrollment,
        "driver": driver?.toJson(),
        "timeStart": timeStart,
        "timeEnd": timeEnd,
        "dateTimeStart": dateTimeStart,
        "dateTimeEnd": dateTimeEnd,
        "active": active,
      };
}
