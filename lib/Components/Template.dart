import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Global/CarsG.dart';
import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Redux/AllStates.dart';
import 'package:valetparking/Views/Parking.dart';
import 'package:valetparking/Views/Drivers/Drivers.dart';
import 'package:valetparking/Views/Home.dart';
import 'package:valetparking/Views/Registers.dart';

class TemplateViews extends StatefulWidget {
  const TemplateViews({Key? key}) : super(key: key);

  @override
  _TemplateViewsState createState() => _TemplateViewsState();
}

class _TemplateViewsState extends State<TemplateViews> {

@override
void initState() { 
  SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  super.initState();
  
}
  ontapCardMenu(index) {
    inputsClear();
    clearInputs();
    reduxSearchBar.dispatch(AccionsSearchBar.SearchFalse);
    switch (index) {
      case 0:
         Util.byteImage = null;
        reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
        reduxMenu.dispatch(AccionsMenu.Home);
        break;
      case 1:
         Util.byteImage = null;
        reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
        reduxMenu.dispatch(AccionsMenu.Register);
        break;
      case 2:
         Util.byteImage = null;
        reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
        reduxMenu.dispatch(AccionsMenu.Car);
        break;
      case 3:
         Util.byteImage = null;
        reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
        reduxMenu.dispatch(AccionsMenu.Driver);
        break;
    }
  }

  switchViews(index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return RegistersView();
      case 2:
        return CarsView();
      case 3:
        return DriversView();
    }
  }

  Widget cardsMenu({id, titleCard, icon}) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 150,
        height: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titleCard,
                style:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              Icon(icon, size: 50)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StoreProvider<int>(
        store: reduxMenu,
        child: StoreConnector<int, dynamic>(
            converter: (reduxMenu) => reduxMenu.state,
            builder: (context, menu) => menu != 0 && menu != 1
                ? FadeInUp(
                  child: FloatingActionButton(
                      onPressed: () {
                        switch (menu) {
                          case 2:
                            inputsClear();
                             Util.byteImage = null;
                            reduxByteImage
                                .dispatch(AccionsByteImage.UpdateByteImage);
                            modalCreatAndEditCars(context,"");
                            break;
                          case 3:
                            clearInputs();
                            Util.byteImage = null;
                            reduxByteImage
                                .dispatch(AccionsByteImage.UpdateByteImage);
                            modalCreatAndEditDrivers(context, isEdit: false);
                            break;
                        }
                      },
                      child: Icon(Icons.add),
                    ),
                )
                : Container()),
      ),
      bottomNavigationBar: StoreProvider<int>(
        store: reduxMenu,
        child: StoreConnector<int, dynamic>(
          converter: (reduxMenu) => reduxMenu.state,
          builder: (context, menu) => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) => ontapCardMenu(index), // new
            currentIndex: menu, // new
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Inicio',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.assignment_rounded),
                label: 'Informes',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.directions_car_filled_rounded),
                label: 'Parking',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.airline_seat_recline_normal_rounded),
                label: 'Conductores',
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: 'background',
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.grey.shade900.withOpacity(0.8),
                          BlendMode.hardLight),
                      image: AssetImage('assets/backgoundLoading.jpeg'),
                      fit: BoxFit.fill)),
            ),
          ),
          SafeArea(
            child: StoreProvider<int>(
              store: reduxMenu,
              child: StoreConnector<int, dynamic>(
                converter: (reduxMenu) => reduxMenu.state,
                builder: (context, menu) => switchViews(menu),

                /* Container(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 30,
                        runSpacing: 30,
                        children: List.generate(
                          itemsMenu.length,
                          (index) => cardsMenu(
                              id: itemsMenu[index]["id"],
                              titleCard: itemsMenu[index]["titleCard"],
                              icon: itemsMenu[index]["icon"]),
                        ),
                      ),
                    ),*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
