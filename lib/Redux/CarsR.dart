import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:valetparking/Global/CarsG.dart';
import 'package:valetparking/Models/Car.dart';


enum AccionsCars { CargarListCars }

List<Cars> reducerListCars(List<Cars> state, dynamic accions) {
  switch (accions) {
    case AccionsCars.CargarListCars:
      return state = listCars;
  }
  return state;
}

final reduxListCars =
    new Store<List<Cars>>(reducerListCars, initialState: listCars);


String reducerTextTime(String state, dynamic accions) {
  return state = accions;
}

final reduxTextTime = new Store<String>(reducerTextTime, initialState: "${DateFormat('jm').format(DateTime.now())}");
