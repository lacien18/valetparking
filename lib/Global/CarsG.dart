import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Components/Input.dart';
import 'package:valetparking/Global/DriversG.dart' as DriverG;
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Models/Car.dart';
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Redux/AllStates.dart';
import 'package:valetparking/Redux/CarsR.dart';
import 'package:valetparking/Global/RegistersG.dart' as RegisterG;

TextEditingController timeStartIngresoController = TextEditingController();
List<Cars> listCars = [];
List<Cars> listCarsFilter = [];
Driver driverSelect = Driver();
FocusNode driverFocus = FocusNode();

parkingTime(time, isdolar) {
  var horaAmin = time[0] * 60;
  var valornim = 1 / 60;
  var sumtime = time[1] + horaAmin;
  var value = valornim * sumtime;
  var valuesSplit = value.toString().split('.');
  if (isdolar) {
    return int.parse(valuesSplit[0]);
  } else {
    return int.parse(valuesSplit[1].length > 3
        ? valuesSplit[1].substring(0, 2)
        : valuesSplit[1]);
  }
}

setCars() async {
  await Util.Storage().setDataCar(jsonEncode(listCarsFilter));
  await Util.Storage().getDataCar();
}

deleteCars(context, id, idParking) async {
  reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
  listCarsFilter.removeWhere((e) => e.id == id);
  await Util.getSites(context, 2, id: idParking);
  await setCars();
}

modalCreatAndEditCars(context, idParking) {
  alertComponent(
    context,
    op: 2,
    title: 'Registrar Entrada',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputComponent(
            autofocus: true,
            onSubmitted: (onsu) {
              driverFocus.requestFocus();
            },
            format: [Util.maskFormatter],
            focusNode: DriverG.enrollment,
            onChanged: (value) {
              if (value != "") {
                searchDriver(value);
                if (Util.enrollmentController.text.length == 7) {
                  driverFocus.requestFocus();
                }
              } else {
                driverSelect = Driver();
                reduxSearchDriver.dispatch(driverSelect);
              }
            },
            controller: Util.enrollmentController,
            icono: Icons.pin_rounded,
            label: 'Placa del vehiculo*'),
        SizedBox(height: 15),
        StoreProvider<Driver>(
          store: reduxSearchDriver,
          child: StoreConnector<Driver, dynamic>(
            converter: (reduxSearchDriver) => reduxSearchDriver.state,
            builder: (context, searchDriver) => inputComponent(
                onSubmitted: (onsu) async {
                  if (Util.enrollmentController.text.length == 7) {
                    await registerCars(context, idParking);
                    Navigator.pop(context);
                  } else {
                    return toastContext(context,
                        text: 'Faltan letras/numeros de la placa',
                        colorFondo: Colors.red,
                        duration: 3);
                  }
                },
                focusNode: driverFocus,
                controller: Util.driverController,
                enableb: searchDriver.enrollment != "" ? false : true,
                icono: Icons.airline_seat_recline_normal_rounded,
                label: searchDriver.enrollment != ""
                    ? searchDriver.driverName
                    : 'Conductor (Opcional)'),
          ),
        ),
        SizedBox(height: 15),
        StoreProvider<Uint8List?>(
          store: reduxByteImage,
          child: StoreConnector<Uint8List?, dynamic>(
            converter: (reduxByteImage) => reduxByteImage.state,
            builder: (context, byteImageS) => StoreProvider<Driver>(
              store: reduxSearchDriver,
              child: StoreConnector<Driver, dynamic>(
                converter: (reduxSearchDriver) => reduxSearchDriver.state,
                builder: (context, searchDriver) => InkWell(
                  onTap: searchDriver.enrollment != ""
                      ? null
                      : () {
                          return alertConfirm(context,
                              title: 'Tomar Foto',
                              content: Text(
                                  'Para tomar la foto de forma correcta ubique el dispositovo de forma horizontal',
                                  style: GoogleFonts.lato()),
                              indexPage: 0,
                              idItem: true,
                              colorHeader: Colors.blue,
                              colorIcono: Colors.blue,
                              icono: Icons.add_a_photo_rounded);
                        },
                  child: byteImageS == null && searchDriver.enrollment == ""
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.add_a_photo_rounded,
                              color: Colors.grey))
                      : byteImageS == null && searchDriver.cacheImage == ""
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.add_a_photo_rounded,
                                  color: Colors.grey))
                          : Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.memory(
                                    searchDriver.enrollment == ""
                                        ? byteImageS
                                        : Util.convertBase64(
                                            searchDriver.cacheImage, 3),
                                    width: 200,
                                    height: 100,
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          Util.byteImage = null;
                                          reduxByteImage.dispatch(
                                              AccionsByteImage.UpdateByteImage);
                                        },
                                        icon: Icon(Icons.close,
                                            color: Colors.red)))
                              ],
                            ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        StoreProvider<String>(
          store: reduxTextTime,
          child: StoreConnector<String, dynamic>(
            converter: (reduxTextTime) => reduxTextTime.state,
            builder: (context, textTime) => inputComponent(
                enableb: false,
                icono: Icons.schedule_outlined,
                label: textTime),
          ),
        ),
      ],
    ),
  );
}

searchDriver(value) {
  List<Driver> driverFound =
      DriverG.listDriversFilter.where((e) => e.enrollment == value).toList();
  if (driverFound.isNotEmpty) {
    driverSelect = driverFound[0];
    reduxSearchDriver.dispatch(driverSelect);
  } else {
    driverSelect = Driver();
    reduxSearchDriver.dispatch(driverSelect);
  }
}

inputsClear() {
  driverSelect = Driver();
  reduxSearchDriver.dispatch(driverSelect);
  Util.enrollmentController.clear();
  timeStartIngresoController.clear();
  Util.driverController.clear();
  reduxTextTime.dispatch("${DateFormat('jm').format(DateTime.now())}");
}

calculateDifferenceHours(Cars itemCar, calculateHours) {
  var hour = itemCar.timeStart.split(":");
  var date = "2019-08-09 " +
      '${int.parse(hour[0]) < 10 ? 0 : ""}' +
      (itemCar.timeStart)
          .replaceAll(RegExp(r"[A-Z]"), "")
          .replaceAll(RegExp(r" "), ":00");
  var hourNow = Util.dateTime.hour.toInt();
  var hourStart = int.parse(DateFormat.j()
      .format(DateTime.parse(date))
      .replaceAll(RegExp(r"[A-Z]"), ""));
  var diferenciahour =
      hourNow > hourStart ? hourNow - hourStart : hourStart - hourNow;
  var minNow = Util.dateTime.minute.toInt();
  var minStart = int.parse(DateFormat.m()
      .format(DateTime.parse(date))
      .replaceAll(RegExp(r"[A-Z]"), ""));
  var diferenciaMin = minNow > minStart ? minNow - minStart : minStart - minNow;
  return [diferenciahour, diferenciaMin];
}

editCars(context, Cars itemCar) async {
  Util.Storage().getDataRegisters();
  Cars editCar = Cars();
  editCar.id = itemCar.id;
  editCar.active = false;
  editCar.driver = itemCar.driver;
  editCar.site = Util.getSites(context, 2, id: itemCar.site?.id);
  editCar.dateTimeStart = itemCar.dateTimeStart;
  editCar.dateTimeEnd = DateFormat('yyyy-MM-dd').format(DateTime.now());
  editCar.enrollment = itemCar.enrollment;
  editCar.timeStart = itemCar.timeStart;
  editCar.dolar = parkingTime(calculateDifferenceHours(itemCar, false), true);
  editCar.pennies =
      parkingTime(calculateDifferenceHours(itemCar, false), false);
  editCar.timeEnd = DateFormat.jm().format(DateTime.now());
  editCar.timeElapsed = calculateDifferenceHours(itemCar, true)[0].toString() +
      ":" +
      calculateDifferenceHours(itemCar, true)[1].toString();
  editCar.hourElapsed = calculateDifferenceHours(itemCar, true)[0].toString();
  editCar.minElapsed = calculateDifferenceHours(itemCar, true)[1].toString();
  editCar.valueParking = "${editCar.dolar}.${editCar.pennies}";
  listCarsFilter.removeWhere((e) => e.id.contains(itemCar.id));
  RegisterG.listRegistersFilter.add(editCar);
  await RegisterG.setRegisters();
  reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
  await setCars();
  inputsClear();
  return alertConfirm(context,
      idItem: editCar,
      indexPage: 2,
      icono: Icons.paid_rounded,
      colorIcono: Colors.blue,
      colorHeader: Colors.blue,
      title: 'Total a pagar',
      op: 3,
      content: Text(
        '${editCar.dolar > 1 ? editCar.dolar.toString() + " DOLARES" : editCar.dolar.toString() + " DOLAR"} Y  ${editCar.pennies > 1 ? editCar.pennies.toString() + " CENTAVOS" : editCar.pennies.toString() + " CENTAVO"}',
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(),
      ));
}

registerCars(context, idParking) async {
  List<Cars> enrollmentSearch = listCarsFilter
      .where((e) => e.enrollment == Util.enrollmentController.text)
      .toList();
  if (enrollmentSearch.isEmpty) {
    if (Util.enrollmentController.text != "") {
      Cars registerCar = Cars();
      if (idParking != null && idParking != "") {
        registerCar.site = Util.getSites(context, 3, id: idParking);
      } else {
        final site = Util.getSites(context, 1);
        if (site != false) {
          registerCar.site = site;
        } else {
          return toastContext(context,
              text: 'Sitios de parking llenos',
              colorFondo: Colors.red,
              duration: 3);
        }
      }
      registerCar.cacheImage = Util.base64Image;
      registerCar.id = Util.uuid.v1();
      registerCar.active = true;
      if (driverSelect.enrollment == "") {
        final driverCreatSimple = Driver(
            cacheImage: Util.base64Image,
            isComplete: false,
            enrollment: Util.enrollmentController.text.toUpperCase(),
            driverName: Util.driverController.text,
            id: Util.uuid.v1());
        registerCar.driver = driverCreatSimple;
        DriverG.listDriversFilter.add(driverCreatSimple);
        await DriverG.setDrivers();
      } else {
        registerCar.driver = driverSelect;
      }
      registerCar.dateTimeStart =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      registerCar.enrollment = Util.enrollmentController.text.toUpperCase();
      registerCar.timeStart = timeStartIngresoController.text == ""
          ? DateFormat.jm().format(DateTime.now())
          : timeStartIngresoController.text;
      listCarsFilter.add(registerCar);
      await setCars();
      inputsClear();
      Util.base64Image = "";
      Util.byteImage = null;
      reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
      return toastContext(context,
          text: 'Vehiculo registrado con exito',
          colorFondo: Colors.green,
          duration: 2);
    } else {
      return toastContext(context,
          text: 'Ingrese la placa del vehiculo',
          colorFondo: Colors.red,
          duration: 3);
    }
  } else {
    return toastContext(context,
        text: 'El vehiculo ya se encuentra registrado',
        colorFondo: Colors.red,
        duration: 3);
  }
}
