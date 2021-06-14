import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:valetparking/Components/CarAndDriver.dart';
import 'package:valetparking/Global/Util.dart' as Util;

class RegistersView extends StatefulWidget {
  const RegistersView({Key? key}) : super(key: key);

  @override
  _RegistersViewState createState() => _RegistersViewState();
}

class _RegistersViewState extends State<RegistersView> {
  @override
  void initState() {
    Util.Storage().getDataRegisters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: CarAndDriver(
        page: 1,
        title: 'INFORME DE ENTRADA Y SALIDA',
      ),
    );
  }
}
