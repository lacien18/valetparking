import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    this.id = "",
    this.driverName = "",
    this.enrollment = "",
    this.phone = 0,
    this.firstName = "",
    this.secondName = "",
    this.firstSurname = "",
    this.secondSurname = "",
    this.identificationCard = 0,
    this.isComplete = false,
    this.cacheImage ="",
  });

  String cacheImage;
  bool isComplete;
  String id;
  String driverName;
  String enrollment;
  int phone;
  String firstName;
  String secondName;
  String firstSurname;
  String secondSurname;
  int identificationCard;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
     cacheImage: json["cacheImage"] == null ? "": json["cacheImage"],
        isComplete: json["isComplete"] == null ? false : json["isComplete"],
        id: json["id"] == null ? "" : json["id"],
        driverName: json["driver_name"] == null ? null : json["driver_name"],
        enrollment: json["enrollment"] == null ? null : json["enrollment"],
        phone: json["phone"] == null ? null : json["phone"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        secondName: json["second_name"] == null ? null : json["second_name"],
        firstSurname:
            json["first_surname"] == null ? null : json["first_surname"],
        secondSurname:
            json["second_surname"] == null ? null : json["second_surname"],
        identificationCard: json["identification_card"] == null
            ? null
            : json["identification_card"],
      );

  Map<String, dynamic> toJson() => {
    "cacheImage":cacheImage,
        "isComplete": isComplete,
        "id": id,
        "driver_name": driverName,
        "enrollment": enrollment,
        "phone": phone,
        "first_name": firstName,
        "second_name": secondName,
        "first_surname": firstSurname,
        "second_surname": secondSurname,
        "identification_card": identificationCard,
      };
}
