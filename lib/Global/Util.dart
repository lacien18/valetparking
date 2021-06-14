import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:valetparking/Global/CarsG.dart' as CarsG;
import 'package:valetparking/Global/DriversG.dart' as DriversG;
import 'package:valetparking/Global/RegistersG.dart' as RegistersG;
import 'package:valetparking/Models/Car.dart';
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Models/Parking.dart';
import 'package:valetparking/Redux/AllStates.dart';
import 'package:valetparking/Redux/CarsR.dart';
import 'package:valetparking/Redux/DriversR.dart';
import 'package:valetparking/Redux/RegistersR.dart';
import 'dart:async';
import 'package:image/image.dart' as ImageProcess;

TextEditingController enrollmentController = TextEditingController();
TextEditingController driverController = TextEditingController();
DateTime dateTime = DateTime.now();
List<File> photos = [];
Uint8List? byteImage;
String base64Image = "";
var listFDrivers = [];
var listFRegisters = [];
var uuid = Uuid();
var maskFormatter = new MaskTextInputFormatter(
    mask: '###-###', filter: {"#": RegExp(r'[0-9-A-Z-a-z]')});

openCamera(context, {close = true}) async {
  final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CameraCamera(
              resolutionPreset: ResolutionPreset.medium,
              enableAudio: true,
              enableZoom: true,
              onFile: (file) {
                Navigator.pop(context, file);
              })));
  if (imagePath != null) {
    File file = File(imagePath.path);
    final _imageFile = ImageProcess.decodeImage(file.readAsBytesSync());
    await convertBase64(_imageFile, 1);
    reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
  }
  if (close) Navigator.pop(context);
}

convertBase64(imageFile, op) {
  switch (op) {
    case 1:
      base64Image = base64Encode(ImageProcess.encodeJpg(imageFile!));
      byteImage = Base64Decoder().convert(base64Image);
      reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
      break;
    case 2:
      byteImage = Base64Decoder().convert(imageFile);
      reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
      break;
    case 3:
      final _byteImage = Base64Decoder().convert(imageFile);

      return _byteImage;
  }
}

loadPopMenu() {
  List<PopupMenuEntry> listdriversF = [];
  listdriversF.add(
    PopupMenuItem(
      enabled: true,
      value: 0,
      child: Center(
          child: Text("ORGANIZAR",
              style: GoogleFonts.lato(fontWeight: FontWeight.bold))),
    ),
  );
  listdriversF.add(
    PopupMenuItem(
      enabled: true,
      value: 1,
      child: Row(
        children: [
          Icon(Icons.text_fields_rounded),
          SizedBox(width: 10),
          Text("A-z", style: GoogleFonts.lato())
        ],
      ),
    ),
  );
  listdriversF.add(
    PopupMenuItem(
      enabled: true,
      value: 2,
      child: Row(
        children: [
          Icon(Icons.format_size_rounded),
          SizedBox(width: 10),
          Text("Z-a", style: GoogleFonts.lato())
        ],
      ),
    ),
  );
  List<PopupMenuEntry> listregistersF = [];
  listregistersF.add(
    PopupMenuItem(
      enabled: true,
      value: 0,
      child: Center(
          child: Text("ORGANIZAR",
              style: GoogleFonts.lato(fontWeight: FontWeight.bold))),
    ),
  );
  listregistersF.add(
    PopupMenuItem(
      enabled: true,
      value: 1,
      child: Row(
        children: [
          Icon(Icons.text_fields_rounded),
          SizedBox(width: 10),
          Text("Por Hora", style: GoogleFonts.lato())
        ],
      ),
    ),
  );
  listregistersF.add(
    PopupMenuItem(
      enabled: true,
      value: 2,
      child: Row(
        children: [
          Icon(Icons.format_size_rounded),
          SizedBox(width: 10),
          Text("Por Fecha", style: GoogleFonts.lato())
        ],
      ),
    ),
  );
  listFRegisters = listregistersF;
  listFDrivers = listdriversF;
}

getSites(context, op, {id}) {
  final validatelisParkings =
      lisParkings.where((e) => e.active == false).toList();
  switch (op) {
    case 1:
      if (validatelisParkings.isNotEmpty) {
        Parking parkingSelect =
            lisParkings.firstWhere((e) => e.active == false);
        parkingSelect.active = true;
        lisParkings.removeWhere((e) => e.id == parkingSelect.id);
        lisParkings.add(parkingSelect);
        Storage().setDataParking(jsonEncode(lisParkings));
        reduxListParkings.dispatch(AccionsParkings.CargarListParkings);
        return parkingSelect;
      } else {
        return false;
      }
    case 2:
        Parking parkingSelect = lisParkings.firstWhere((e) => e.id == id);
        parkingSelect.active = false;
        lisParkings.removeWhere((e) => e.id == parkingSelect.id);
        lisParkings.add(parkingSelect);
        Storage().setDataParking(jsonEncode(lisParkings));
        reduxListParkings.dispatch(AccionsParkings.CargarListParkings);
        return parkingSelect;
    case 3:
      if (validatelisParkings.isNotEmpty) {
        Parking parkingSelect = Parking();
        final parkingSelectSearch =
            lisParkings.where((e) => e.id == id).toList();
        if (parkingSelectSearch[0].id != "") {
          parkingSelectSearch[0].active = true;
          parkingSelect.active = true;
          parkingSelect.id = parkingSelectSearch[0].id;
          parkingSelect.idCars = "";
          parkingSelect.siteName = parkingSelectSearch[0].siteName;
          lisParkings.removeWhere((e) => e.id == parkingSelect.id);
          lisParkings.add(parkingSelect);
          Storage().setDataParking(jsonEncode(lisParkings));
          reduxListParkings.dispatch(AccionsParkings.CargarListParkings);
          return parkingSelect;
        }
      } else {
        return false;
      }
  }
}

List<Parking> lisParkings = [
  Parking(
    siteName: "A1",
    active: false,
    id: "parkingA1",
    idCars: "",
  ),
  Parking(
    siteName: "A2",
    active: false,
    id: "parking21",
    idCars: "",
  ),
  Parking(
    siteName: "B1",
    active: false,
    id: "parkingB1",
    idCars: "",
  ),
  Parking(
    siteName: "B2",
    active: false,
    id: "parkingB2",
    idCars: "",
  ),
  Parking(
    siteName: "C1",
    active: false,
    id: "parkingC1",
    idCars: "",
  ),
  Parking(
    siteName: "C2",
    active: false,
    id: "parkingC2",
    idCars: "",
  ),
  Parking(
    siteName: "D1",
    active: false,
    id: "parkingD1",
    idCars: "",
  ),
  Parking(
    siteName: "D2",
    active: false,
    id: "parkingD2",
    idCars: "",
  ),
];

searchItemPage(op, value) {
  switch (op) {
    case 1:
      RegistersG.listRegisters = RegistersG.listRegistersFilter;
      RegistersG.listRegisters = RegistersG.listRegisters
          .where((e) => e.enrollment.contains(value))
          .toList();
      reduxListRegisters.dispatch(AccionsRegisters.CargarListRegisters);
      break;
    case 2:
      CarsG.listCars = CarsG.listCarsFilter;
      CarsG.listCars =
          CarsG.listCars.where((e) => e.enrollment.contains(value)).toList();
      reduxListCars.dispatch(AccionsCars.CargarListCars);
      break;
    case 3:
      DriversG.listDrivers = DriversG.listDriversFilter;
      DriversG.listDrivers = DriversG.listDrivers
          .where((e) =>
              e.driverName.contains(value) ||
              e.identificationCard.toString().contains(value))
          .toList();
      reduxListDriver.dispatch(AccionsDriver.CargarListDriver);
      break;
  }
}

class Storage {
  Future<SharedPreferences> prefsLoad = SharedPreferences.getInstance();

  getDataParking() async {
    SharedPreferences prefs = await prefsLoad;
    var dataPrefs = prefs.getString('DataParking') ?? "";
    if (dataPrefs != "") {
      var data = jsonDecode(dataPrefs);
      lisParkings.clear();
      for (var item in data) {
        lisParkings.add(Parking.fromJson(item));
      }
    }
    reduxListParkings.dispatch(AccionsParkings.CargarListParkings);
  }

  setDataParking(String value) async {
    SharedPreferences prefs = await prefsLoad;
    prefs.setString('DataParking', value);
  }

  getDataCar() async {
    SharedPreferences prefs = await prefsLoad;
    var dataPrefs = prefs.getString('DataCar') ?? "";
    if (dataPrefs != "") {
      var data = jsonDecode(dataPrefs);
      CarsG.listCars.clear();
      CarsG.listCarsFilter.clear();
      for (var item in data) {
        CarsG.listCars.add(Cars.fromJson(item));
        CarsG.listCarsFilter.add(Cars.fromJson(item));
      }
    }
    reduxListCars.dispatch(AccionsCars.CargarListCars);
  }

  setDataCar(String value) async {
    SharedPreferences prefs = await prefsLoad;
    prefs.setString('DataCar', value);
  }

  getDataDriver() async {
    SharedPreferences prefs = await prefsLoad;
    var dataPrefs = prefs.getString('DataDriver') ?? "";
    if (dataPrefs != "") {
      var data = jsonDecode(dataPrefs);
      DriversG.listDrivers.clear();
      DriversG.listDriversFilter.clear();
      for (var item in data) {
        DriversG.listDrivers.add(Driver.fromJson(item));
        DriversG.listDriversFilter.add(Driver.fromJson(item));
      }
    }
    reduxListDriver.dispatch(AccionsDriver.CargarListDriver);
  }

  setDataDriver(String value) async {
    SharedPreferences prefs = await prefsLoad;
    prefs.setString('DataDriver', value);
  }

  getDataRegisters() async {
    SharedPreferences prefs = await prefsLoad;
    var dataPrefs = prefs.getString('DataRegisters') ?? "";
    if (dataPrefs != "") {
      var data = jsonDecode(dataPrefs);
      RegistersG.listRegisters.clear();
      RegistersG.listRegistersFilter.clear();
      for (var item in data) {
        RegistersG.listRegisters.add(Cars.fromJson(item));
        RegistersG.listRegistersFilter.add(Cars.fromJson(item));
      }
    }
    RegistersG.listRegistersFilter
        .sort((b, a) => a.timeStart.compareTo(b.timeStart));
    RegistersG.listRegisters.sort((b, a) => a.timeStart.compareTo(b.timeStart));
    reduxListRegisters.dispatch(AccionsRegisters.CargarListRegisters);
  }

  setDataRegisters(String value) async {
    SharedPreferences prefs = await prefsLoad;
    prefs.setString('DataRegisters', value);
  }
}
