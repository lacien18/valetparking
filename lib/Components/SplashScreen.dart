import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Components/Template.dart';
import 'package:valetparking/Global/Util.dart' as Util;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    goToHomePage();
    super.initState();
  }

  goToHomePage() async {
    await Util.loadPopMenu();
    await Util.Storage().getDataParking();
    await Util.Storage().getDataDriver();
    await Util.Storage().getDataCar();
    await Util.Storage().getDataRegisters();
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => TemplateViews()),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'splash',
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/backgoundLoading.jpeg'),
                      fit: BoxFit.fill)),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.9,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text('Cargando...',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white)),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 220,
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
