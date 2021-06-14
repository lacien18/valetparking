import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Components/DetailAndDriverRegister.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Redux/AllStates.dart';

List<Driver> listDrivers = [];
List<Driver> listDriversFilter = [];
FocusNode firstName = FocusNode();
FocusNode secondName = FocusNode();
FocusNode firstSurname = FocusNode();
FocusNode secondSurname = FocusNode();
FocusNode phone = FocusNode();
FocusNode enrollment = FocusNode();
FocusNode identificationCard = FocusNode();
TextEditingController firstNameController = TextEditingController();
TextEditingController secondNameController = TextEditingController();
TextEditingController firstSurnameController = TextEditingController();
TextEditingController secondSurnameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController identificationCardController = TextEditingController();

modalCreatAndEditDrivers(context, {isEdit = false, itemDriver}) async {
  if (isEdit) {
    firstNameController.text = itemDriver.firstName;
    secondNameController.text = itemDriver.secondName;
    firstSurnameController.text = itemDriver.firstSurname;
    secondSurnameController.text = itemDriver.secondSurname;
    identificationCardController.text =
        itemDriver.identificationCard.toString();
    phoneController.text = itemDriver.phone.toString();
    Util.enrollmentController.text = itemDriver.enrollment;
  }
  await Navigator.push(
    context,
    MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return DetailAndDriverRegister(
            registerSelect: "", op: 2, isEdit: isEdit, itemDriver: itemDriver);
      },
      fullscreenDialog: true,
    ),
  );
}

clearInputs() {
  firstNameController.clear();
  secondNameController.clear();
  firstSurnameController.clear();
  secondSurnameController.clear();
  phoneController.clear();
  identificationCardController.clear();
  Util.enrollmentController.clear();
}

registerAndEditDrivers(context, {isEdit = false, itemDriver}) async {
  reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
  Driver driver = Driver();
  isEdit ? driver.id = itemDriver.id : driver.id = Util.uuid.v1();
  if (Util.enrollmentController.text == "") {
    return toastContext(context,
        text: 'La placa del vehiculo es un campo requerido',
        colorFondo: Colors.red,
        duration: 3);
  }
  if (identificationCardController.text == "") {
    return toastContext(context,
        text: 'La identificacion es un campo requerido',
        colorFondo: Colors.red,
        duration: 3);
  }
  if (firstNameController.text == "") {
    return toastContext(context,
        text: 'Primer nombre es un campo requerido',
        colorFondo: Colors.red,
        duration: 3);
  }
  if (firstSurnameController.text == "") {
    return toastContext(context,
        text: 'Primer apellido es un campo requerido',
        colorFondo: Colors.red,
        duration: 3);
  }
  List<Driver> enrollmentExist = listDriversFilter
      .where(
          (e) => e.enrollment == Util.enrollmentController.text.toUpperCase())
      .toList();

  if (!isEdit && enrollmentExist.isNotEmpty) {
    return toastContext(context,
        text: 'Esta placa ya se encuentra registrada',
        colorFondo: Colors.red,
        duration: 3);
  }
  List<Driver> driverExist = listDriversFilter
      .where((e) =>
          e.identificationCard == int.parse(identificationCardController.text))
      .toList();
  if (!isEdit && driverExist.isNotEmpty) {
    return toastContext(context,
        text: 'Este conductor ya se encuentra registrado',
        colorFondo: Colors.red,
        duration: 3);
  }
  if (firstNameController.text != "" &&
      firstSurnameController.text != "" &&
      identificationCardController.text != "" &&
      Util.enrollmentController.text != "") {
    if (isEdit) listDriversFilter.removeWhere((e) => e.id == itemDriver.id);
    driver.firstName = firstNameController.text.toUpperCase();
    driver.secondName = secondNameController.text.toUpperCase();
    driver.firstSurname = firstSurnameController.text.toUpperCase();
    driver.secondSurname = secondSurnameController.text.toUpperCase();
    driver.identificationCard = int.parse(identificationCardController.text);
    driver.isComplete = true;
    driver.cacheImage = isEdit
        ? Util.base64Image == ""
            ? itemDriver.cacheImage
            : Util.base64Image
        : Util.base64Image;
    driver.phone =
        phoneController.text == "" ? 0 : int.parse(phoneController.text);
    driver.enrollment = Util.enrollmentController.text.toUpperCase();
    driver.driverName = firstNameController.text.toUpperCase() +
        " " +
        firstSurnameController.text.toUpperCase();
    clearInputs();
    Util.base64Image = "";
    Util.byteImage = null;
    reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
    Navigator.pop(context);
    listDriversFilter.add(driver);
    await setDrivers();
    return toastContext(context,
        text: isEdit
            ? 'Conductor editado con exito'
            : 'Conductor registrado con exito',
        colorFondo: isEdit ? Colors.orangeAccent : Colors.green,
        duration: 3);
  }
}

deleteDriver(context, id) async {
  reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
  listDriversFilter.removeWhere((e) => e.id == id);
  await setDrivers();
  toastContext(context,
      text: 'Conductor eliminado con exito',
      colorFondo: Colors.green,
      duration: 2);
}

setDrivers() async {
  await Util.Storage().setDataDriver(jsonEncode(listDriversFilter));
  await Util.Storage().getDataDriver();
}
