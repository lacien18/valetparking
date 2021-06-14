import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Components/CarAndDriver.dart';

class CarsView extends StatefulWidget {
  const CarsView({Key? key}) : super(key: key);

  @override
  _CarsViewState createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {
  @override
  void initState() {
    Util.Storage().getDataCar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: CarAndDriver(
        page: 2,
        title: 'REGISTRO DE PARKING',
      ),
    );
  }
}
