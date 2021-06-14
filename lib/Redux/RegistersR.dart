import 'package:redux/redux.dart';
import 'package:valetparking/Global/RegistersG.dart';
import 'package:valetparking/Models/Car.dart';

enum AccionsRegisters { CargarListRegisters}

List<Cars> reducerListRegisters(List<Cars> state, dynamic accions) {
  switch (accions) {
    case AccionsRegisters.CargarListRegisters:
      return state = listRegisters;
  }
  return state;
}

final reduxListRegisters =
    new Store<List<Cars>>(reducerListRegisters, initialState: listRegisters);
