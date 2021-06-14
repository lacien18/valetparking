import 'package:flutter/material.dart';
import 'package:valetparking/Global/CarsG.dart' as CarsG;
import 'package:valetparking/Global/DriversG.dart' as DriversG;
import 'package:valetparking/Global/RegistersG.dart' as RegisterG;
import 'package:valetparking/Redux/CarsR.dart';
import 'package:valetparking/Redux/DriversR.dart';
import 'package:valetparking/Redux/RegistersR.dart';

Widget popMenu({tooltip, lista, op, indexPage}) {
  return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(10.0),
      tooltip: tooltip,
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.filter_alt_rounded, color: Colors.white)),
      onSelected: (value) async {
        switch (indexPage) {
            case 1:
            switch (value) {
              case 1:
                  RegisterG.listRegisters
                    .sort((b, a) => a.timeStart.compareTo(b.timeStart));
                RegisterG.listRegistersFilter
                    .sort((b, a) => a.timeStart.compareTo(b.timeStart));
                reduxListRegisters
                    .dispatch(AccionsRegisters.CargarListRegisters);
                break;
              case 2:
                 RegisterG.listRegisters
                    .sort((b, a) => a.dateTimeStart.compareTo(b.dateTimeStart));
                RegisterG.listRegistersFilter
                    .sort((b, a) => a.dateTimeStart.compareTo(b.dateTimeStart));
                reduxListRegisters
                    .dispatch(AccionsRegisters.CargarListRegisters);
                break;
            }
            break;
          case 2:
           switch (value) {
              case 1:
                CarsG.listCars
                    .sort((a, b) => a.enrollment.compareTo(b.enrollment));
                reduxListCars.dispatch(AccionsCars.CargarListCars);
                break;
              case 2:
               CarsG.listCars
                    .sort((b, a) => a.enrollment.compareTo(b.enrollment));
                reduxListCars.dispatch(AccionsCars.CargarListCars);
                break;
            }
            break;
          case 3:
            switch (value) {
              case 1:
                DriversG.listDrivers
                    .sort((a, b) => a.driverName.compareTo(b.driverName));
                reduxListDriver.dispatch(AccionsDriver.CargarListDriver);
                break;
              case 2:
                DriversG.listDrivers
                    .sort((b, a) => a.driverName.compareTo(b.driverName));
                reduxListDriver.dispatch(AccionsDriver.CargarListDriver);
                break;
            }
            break;
        }
      },
      itemBuilder: (BuildContext context) => lista);
}
