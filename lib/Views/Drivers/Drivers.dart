import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:valetparking/Components/CarAndDriver.dart';
import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Global/Util.dart' as Util;

class DriversView extends StatefulWidget {
  const DriversView({Key? key}) : super(key: key);

  @override
  _DriversViewState createState() => _DriversViewState();
}

class _DriversViewState extends State<DriversView> {
  @override
  void initState() {
    firstName = FocusNode();
    secondName = FocusNode();
    firstSurname = FocusNode();
    secondSurname = FocusNode();
    phone = FocusNode();
    enrollment = FocusNode();
    identificationCard = FocusNode();
    Util.Storage().getDataDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: CarAndDriver(
        page: 3,
        title: 'REGISTRO DE CONDUCTORES',
      ),
    );
  }
}
