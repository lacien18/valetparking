import 'dart:typed_data';

import 'package:redux/redux.dart';
import 'package:valetparking/Global/CarsG.dart';
import 'package:valetparking/Global/Util.dart';
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Models/Parking.dart';

enum AccionsMenu { Home, Car, Driver, Register }
int reducerMenu(int state, dynamic accions) {
  switch (accions) {
    case AccionsMenu.Home:
      state = 0;
      break;
    case AccionsMenu.Register:
      state = 1;
      break;
    case AccionsMenu.Car:
      state = 2;
      break;
    case AccionsMenu.Driver:
      state = 3;
      break;
  }
  return state;
}

final reduxMenu = new Store<int>(reducerMenu, initialState: 0);

String reducerLoading(String state, dynamic accion) {
  return state = accion;
}

final reduxLoading = new Store<String>(reducerLoading, initialState: "");

Driver reducerSearchDriver(Driver state, dynamic accions) {
  return state = accions;
}

final reduxSearchDriver = new Store<Driver>(
  reducerSearchDriver,
  initialState: driverSelect,
);

enum AccionsSearchBar { SearchTrue, SearchFalse }

bool reducerSearchBar(bool state, dynamic accions) {
  switch (accions) {
    case AccionsSearchBar.SearchTrue:
      return state = true;

    case AccionsSearchBar.SearchFalse:
      return state = false;
  }
  return state;
}

final reduxSearchBar = new Store<bool>(reducerSearchBar, initialState: false);

enum AccionsParkings { CargarListParkings }

List<Parking> reducerListParkings(List<Parking> state, dynamic accions) {
  switch (accions) {
    case AccionsParkings.CargarListParkings:
      return state = lisParkings;
  }
  return state;
}

final reduxListParkings =
    new Store<List<Parking>>(reducerListParkings, initialState: lisParkings);

enum AccionsByteImage { UpdateByteImage }

Uint8List? reducerByteImage(Uint8List? state, dynamic accions) {
  switch (accions) {
    case AccionsByteImage.UpdateByteImage:
      return state = byteImage;
  }
}

final reduxByteImage = Store<Uint8List?>(
  reducerByteImage,
  initialState: null
);
