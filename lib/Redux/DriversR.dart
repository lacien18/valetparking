import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Models/Driver.dart';
import 'package:redux/redux.dart';

enum AccionsDriver { CargarListDriver }

List<Driver> reducerListDriver(List<Driver> state, dynamic accions) {
  switch (accions) {
    case AccionsDriver.CargarListDriver:
      return state = listDrivers;
  }
  return state;
}

final reduxListDriver =
    new Store<List<Driver>>(reducerListDriver, initialState: listDrivers);
