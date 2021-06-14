import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Models/Car.dart';
import 'package:valetparking/Redux/AllStates.dart';

List<Cars> listRegisters = [];
List<Cars> listRegistersFilter = [];

setRegisters() async {
  await Util.Storage().setDataRegisters(jsonEncode(listRegistersFilter));
  await Util.Storage().getDataRegisters();
}

deleteRegister(context, id) async {
  reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
  listRegistersFilter.removeWhere((e) => e.id == id);
  await setRegisters();
  return toastContext(context,
      text: 'Registro eliminado con exito',
      colorFondo: Colors.green,
      duration: 2);
}

updateDriver(idDriver, idRegister) async {
  final driver = listDriversFilter.where((e) => e.id == idDriver).toList();
  if (driver.isNotEmpty) {
    final register =
        listRegistersFilter.where((e) => e.id == idRegister).toList();
    listRegistersFilter.removeWhere((e) => e.id == idRegister);
    register[0].driver = driver[0];
    listRegistersFilter.add(register[0]);
    await setRegisters();
  }
  final registerSeeDetail =
      listRegistersFilter.where((e) => e.id == idRegister).toList();
  return registerSeeDetail[0];
}
