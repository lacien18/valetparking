import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Global/CarsG.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Models/Car.dart';
import 'package:valetparking/Models/Parking.dart';
import 'package:valetparking/Redux/AllStates.dart';
import 'package:valetparking/Redux/CarsR.dart';
import 'package:valetparking/Redux/RegistersR.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Util.Storage().getDataParking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Valet Parcking',
              style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            StoreProvider<List<Cars>>(
              store: reduxListRegisters,
              child: StoreConnector<List<Cars>, dynamic>(
                converter: (reduxListRegisters) => reduxListRegisters.state,
                builder: (context, listRegistersS) => Card(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.event_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Registros del dia',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        Text(
                          listRegistersS
                              .where((e) =>
                                  e.dateTimeStart ==
                                  DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()))
                              .toList()
                              .length
                              .toString(),
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            StoreProvider<List<Cars>>(
              store: reduxListCars,
              child: StoreConnector<List<Cars>, dynamic>(
                converter: (reduxListCars) => reduxListCars.state,
                builder: (context, listCarsS) => Card(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.directions_car_rounded,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Vehiculos en Parking',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        Text(
                          listCarsS.length.toString(),
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Sitios de Parking',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: StoreProvider<List<Parking>>(
                  store: reduxListParkings,
                  child: StoreConnector<List<Parking>, dynamic>(
                    converter: (reduxListParkings) => reduxListParkings.state,
                    builder: (context, listParkings) => GridView.count(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: List.generate(
                        listParkings.length,
                        (index) => InkWell(
                          onTap: () {
                            if (!listParkings[index].active) {
                              inputsClear();
                              modalCreatAndEditCars(
                                  context, listParkings[index].id);
                            } else {
                              return toastContext(context,
                                  text: 'Sitio Ocupado',
                                  colorFondo: Colors.red,
                                  duration: 2);
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            color: listParkings[index].active
                                ? Colors.redAccent.withOpacity(0.7)
                                : Colors.greenAccent.withOpacity(0.7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /* Icon(
                                  listParkings[index].active
                                      ?Icons.disabled_by_default_rounded //Icons.remove_done_rounded
                                      : Icons.garage,//Icons.done_all_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),*/
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    '${listParkings[index].siteName}',
                                    style: GoogleFonts.lato(
                                        color:listParkings[index].active ?Colors.red:Colors.green,
                                        fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  listParkings[index].active
                                      ? 'OCUPADO'
                                      : 'LIBRE',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
