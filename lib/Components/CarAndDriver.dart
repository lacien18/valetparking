import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Components/DetailAndDriverRegister.dart';
import 'package:valetparking/Components/Input.dart';
import 'package:valetparking/Components/PopMenu.dart';
import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Global/RegistersG.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Models/Car.dart';
import 'package:valetparking/Models/Driver.dart';
import 'package:valetparking/Redux/AllStates.dart';
import 'package:valetparking/Redux/CarsR.dart';
import 'package:valetparking/Redux/DriversR.dart';
import 'package:valetparking/Redux/RegistersR.dart';

class CarAndDriver extends StatefulWidget {
  CarAndDriver({Key? key, required this.page, required this.title})
      : super(key: key);

  final int page;
  final String title;

  @override
  _CarAndDriverState createState() => _CarAndDriverState();
}

class _CarAndDriverState extends State<CarAndDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            StoreProvider<bool>(
              store: reduxSearchBar,
              child: StoreConnector<bool, dynamic>(
                converter: (reduxSearchBar) => reduxSearchBar.state,
                builder: (context, searchBar) => searchBar == true
                    ? Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: inputComponent(
                                  contentPadding: EdgeInsets.all(0),
                                  onChanged: (value) {
                                    Util.searchItemPage(widget.page, value);
                                  },
                                  format: widget.page == 2 || widget.page == 1
                                      ? [Util.maskFormatter]
                                      : null,
                                  style: 2,
                                  focusNode: enrollment,
                                  icono: Icons.search_rounded,
                                  label: widget.page == 2 || widget.page == 1
                                      ? 'Buscar Placa'
                                      : 'Buscar Conductor'),
                            ),
                            IconButton(
                                onPressed: () {
                                  reduxSearchBar
                                      .dispatch(AccionsSearchBar.SearchFalse);
                                  switch (widget.page) {
                                    case 1:
                                      Util.Storage().getDataRegisters();
                                      break;
                                    case 2:
                                      Util.Storage().getDataCar();
                                      break;
                                    case 3:
                                      Util.Storage().getDataDriver();
                                      break;
                                  }
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      reduxSearchBar.dispatch(
                                          AccionsSearchBar.SearchTrue);
                                      enrollment.requestFocus();
                                    },
                                    icon: Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                    )),
                                popMenu(indexPage: widget.page,
                                  tooltip: 'Filtro',lista: widget.page == 3?Util.listFDrivers :widget.page ==2? Util.listFDrivers
                                          : Util.listFRegisters,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Center(
                        child: Text(
                      widget.page == 1
                          ? 'VEHICULO'
                          : widget.page == 2
                              ? 'PLACA'
                              : 'CONDUCTOR',
                      style: GoogleFonts.lato(color: Colors.white),
                    )),
                    leading: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                            widget.page == 1
                                ? 'ENTRADA'
                                : widget.page == 2
                                    ? 'SITIO'
                                    : 'ESTADO',
                            style: GoogleFonts.lato(color: Colors.white))),
                    trailing: Text(widget.page == 1 ? 'SALIDA' : 'ACCIONES',
                        style: GoogleFonts.lato(color: Colors.white)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StoreProvider<List<Cars>>(
                store: reduxListCars,
                child: StoreConnector<List<Cars>, dynamic>(
                  converter: (reduxListCars) => reduxListCars.state,
                  builder: (context, listCarsS) => StoreProvider<List<Driver>>(
                    store: reduxListDriver,
                    child: StoreConnector<List<Driver>, dynamic>(
                      converter: (reduxListDriver) => reduxListDriver.state,
                      builder: (context, listDriverS) =>
                          StoreProvider<List<Cars>>(
                        store: reduxListRegisters,
                        child: StoreConnector<List<Cars>, dynamic>(
                          converter: (reduxListRegisters) =>
                              reduxListRegisters.state,
                          builder: (context, listRegistersS) => Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                              widget.page == 1
                                  ? listRegistersS.length
                                  : widget.page == 2
                                      ? listCarsS.length
                                      : listDriverS.length,
                              (index) => listRegistersS.length == 0 &&
                                      widget.page == 1
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text('NO HAY REGISTROS'))
                                  : listCarsS.length == 0 && widget.page == 2
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                              'NO HAY VEHICULOS REGISTRADOS',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white)))
                                      : listDriverS.length == 0 &&
                                              widget.page == 3
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  'NO HAY CONDUCTORES REGISTRADOS'))
                                          : Card(
                                              color: Colors.transparent,
                                              child: ListTile(
                                                onTap: widget.page == 1
                                                    ? () async {
                                                        updateDriver(
                                                            listRegistersS[
                                                                    index]
                                                                .driver
                                                                .id,
                                                            listRegistersS[
                                                                    index]
                                                                .id);
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              Null>(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return DetailAndDriverRegister(
                                                                registerSelect:
                                                                    listRegistersS[
                                                                        index],
                                                                op: 1,
                                                                isEdit: false,
                                                              );
                                                            },
                                                            fullscreenDialog:
                                                                true,
                                                          ),
                                                        );
                                                      }
                                                    : null,
                                                leading: widget.page == 1
                                                    ? Column(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .meeting_room_rounded,
                                                            color: Colors.green,
                                                          ),
                                                          Text(
                                                            '${listRegistersS[index].timeStart}',
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )
                                                    : widget.page == 2
                                                        ? CircleAvatar(
                                                            backgroundColor: widget
                                                                        .page ==
                                                                    2
                                                                ? listCarsS[index]
                                                                        .active
                                                                    ? Colors
                                                                        .blue
                                                                    : Colors.red
                                                                : listDriverS[
                                                                            index]
                                                                        .isComplete
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .orangeAccent,
                                                            child: widget
                                                                        .page ==
                                                                    2
                                                                ? Text(
                                                                    '${listCarsS[index].site.siteName}',
                                                                    style: GoogleFonts.lato(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : SizedBox
                                                                    .shrink())
                                                        : StoreProvider<
                                                            Uint8List?>(
                                                            store:
                                                                reduxByteImage,
                                                            child:
                                                                StoreConnector<
                                                                    Uint8List?,
                                                                    dynamic>(
                                                              converter:
                                                                  (reduxByteImage) =>
                                                                      reduxByteImage
                                                                          .state,
                                                              builder: (context,
                                                                      byteImageS) =>
                                                                  Container(
                                                                width: 80,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                  width: 2,
                                                                  color: listDriverS[
                                                                              index]
                                                                          .isComplete
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .orangeAccent,
                                                                )),
                                                                child: listDriverS[index]
                                                                            .cacheImage ==
                                                                        ""
                                                                    ? Icon(
                                                                        Icons
                                                                            .no_photography_rounded,
                                                                        color: Colors
                                                                            .white)
                                                                    : Image
                                                                        .memory(
                                                                        Util.convertBase64(
                                                                            listDriverS[index].cacheImage,
                                                                            3),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                title: Container(
                                                  alignment: widget.page == 1
                                                      ? Alignment.center
                                                      : Alignment.centerLeft,
                                                  child: Text(
                                                    widget.page == 1
                                                        ? '${listRegistersS[index].enrollment}'
                                                        : widget.page == 2
                                                            ? 'Placa: ${listCarsS[index].enrollment}'
                                                            : "${listDriverS[index].driverName == "" ? "CONDUCTOR NO REGISTRADO" : listDriverS[index].driverName}",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      widget.page == 1
                                                          ? CrossAxisAlignment
                                                              .center
                                                          : CrossAxisAlignment
                                                              .start,
                                                  children: [
                                                    Text(
                                                      widget.page == 1
                                                          ? '${listRegistersS[index].dateTimeStart}'
                                                          : widget.page == 2
                                                              ? '${listCarsS[index].driver.driverName == "" ? "CONDUCTOR NO REGISTRADO" : listCarsS[index].driver.driverName}'
                                                              : 'Placa: ${listDriverS[index].enrollment}',
                                                      style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    widget.page == 2 ||
                                                            widget.page == 1
                                                        ? Text(
                                                            widget.page == 2
                                                                ? 'Ingreso: ${listCarsS[index].timeStart}'
                                                                : 'Click para ver detalle',
                                                            style: GoogleFonts.lato(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : SizedBox.shrink()
                                                  ],
                                                ),
                                                trailing: widget.page == 1
                                                    ? Column(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .no_meeting_room_rounded,
                                                              color:
                                                                  Colors.red),
                                                          Text(
                                                            '${listRegistersS[index].timeEnd}',
                                                            style: GoogleFonts.lato(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )
                                                    : Wrap(
                                                        children: [
                                                          widget.page == 2
                                                              ? SizedBox
                                                                  .shrink()
                                                              : IconButton(
                                                                  tooltip:
                                                                      'Editar Registro',
                                                                  onPressed:
                                                                      () async {
                                                                    if (widget
                                                                            .page ==
                                                                        2) {
                                                                      /*   CarsG.modalCreatAndEditCars(
                                                                    context,
                                                                    isEdit:
                                                                        true,
                                                                    itemCar:
                                                                        listCarsS[
                                                                            index]);*/
                                                                    }
                                                                    if (widget
                                                                            .page ==
                                                                        3) {
                                                                      await modalCreatAndEditDrivers(
                                                                          context,
                                                                          isEdit:
                                                                              true,
                                                                          itemDriver:
                                                                              listDriverS[index]);
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .edit_rounded,
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                  ),
                                                                ),
                                                          IconButton(
                                                            tooltip:
                                                                'Eliminar Registro',
                                                            onPressed:
                                                                () async {
                                                              switch (
                                                                  widget.page) {
                                                                case 2:
                                                                  await alertConfirm(
                                                                      context,
                                                                      title:
                                                                          'Eliminar',
                                                                      icono: Icons
                                                                          .delete,
                                                                      content: Text(
                                                                          '¿Seguro desea realizar esta accion?, el dato se eliminara de forma permanente'),
                                                                      colorIcono:
                                                                          Colors
                                                                              .red,
                                                                      colorHeader:
                                                                          Colors
                                                                              .red,
                                                                      op: 1,
                                                                      indexPage:
                                                                          2,
                                                                      idItem: widget.page ==
                                                                              2
                                                                          ? listCarsS[index]
                                                                              .id
                                                                          : "",
                                                                      idParking: listCarsS[
                                                                              index]
                                                                          .site
                                                                          .id);
                                                                  break;
                                                                case 3:
                                                                  await alertConfirm(
                                                                      context,
                                                                      title:
                                                                          'Eliminar',
                                                                      icono: Icons
                                                                          .delete,
                                                                      content: Text(
                                                                          '¿Seguro desea realizar esta accion?, el dato se eliminara de forma permanente'),
                                                                      colorIcono:
                                                                          Colors
                                                                              .red,
                                                                      colorHeader:
                                                                          Colors
                                                                              .red,
                                                                      op: 1,
                                                                      indexPage:
                                                                          3,
                                                                      idItem: listDriverS[
                                                                              index]
                                                                          .id);
                                                                  break;
                                                              }
                                                            },
                                                            icon: Icon(
                                                                Icons
                                                                    .delete_rounded,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          widget.page == 2
                                                              ? IconButton(
                                                                  tooltip:
                                                                      'Registrar Salida',
                                                                  onPressed:
                                                                      () async {
                                                                    await alertConfirm(
                                                                        context,
                                                                        title:
                                                                            'Registrar Salida',
                                                                        icono: Icons
                                                                            .verified_rounded,
                                                                        content:
                                                                            Text(
                                                                                '¿Seguro desea registrar la salida del vehiculo?'),
                                                                        colorIcono:
                                                                            Colors
                                                                                .blue,
                                                                        colorHeader:
                                                                            Colors
                                                                                .blue,
                                                                        op: 2,
                                                                        register:
                                                                            true,
                                                                        indexPage:
                                                                            2,
                                                                        idItem:
                                                                            listCarsS[index]);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .verified_rounded,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                )
                                                              : SizedBox
                                                                  .shrink()
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
