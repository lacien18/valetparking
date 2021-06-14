import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Components/Alert.dart';
import 'package:valetparking/Global/DriversG.dart' as DriverG;
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Redux/AllStates.dart';
import 'Input.dart';

class DetailAndDriverRegister extends StatefulWidget {
  final registerSelect;
  final int op;
  final bool isEdit;
  final itemDriver;

  DetailAndDriverRegister(
      {Key? key,
      this.registerSelect,
      required this.op,
      required this.isEdit,
      this.itemDriver})
      : super(key: key);

  @override
  _DetailAndDriverRegisterState createState() =>
      _DetailAndDriverRegisterState();
}

class _DetailAndDriverRegisterState extends State<DetailAndDriverRegister> {
  @override
  void initState() {
    if (widget.itemDriver != null && widget.itemDriver.cacheImage != "")
      Util.convertBase64(widget.itemDriver.cacheImage, 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            )),
                        Text(
                          widget.op == 1 ? 'REGISTRO' : 'REGISTRAR CONDUCTOR',
                          style: GoogleFonts.lato(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  widget.op == 1
                      ? Column(
                          children: [
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.meeting_room_rounded,
                                          color: Colors.green,
                                          size: 35,
                                        ),
                                        SizedBox(width: 15),
                                        Column(
                                          children: [
                                            Text('Fecha Inicio',
                                                style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.white)),
                                            Text(
                                                widget.registerSelect
                                                    .dateTimeStart,
                                                style: GoogleFonts.lato(
                                                    color: Colors.white)),
                                            Text(
                                                widget.registerSelect.timeStart,
                                                style: GoogleFonts.lato(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text('Fecha Fin',
                                                style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.white)),
                                            Text(
                                                widget
                                                    .registerSelect.dateTimeEnd,
                                                style: GoogleFonts.lato(
                                                    color: Colors.white)),
                                            Text(widget.registerSelect.timeEnd,
                                                style: GoogleFonts.lato(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(width: 15),
                                        Icon(Icons.no_meeting_room_rounded,
                                            color: Colors.red, size: 35),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Vehiculo',
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      widget.registerSelect.enrollment,
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Conductor',
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nombre Del Registro',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .driverName ==
                                                  ""
                                              ? 'No Registra'
                                              : widget.registerSelect.driver!
                                                  .driverName,
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Identificacion',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .identificationCard ==
                                                  0
                                              ? "No Registra"
                                              : widget.registerSelect.driver!
                                                  .identificationCard
                                                  .toString(),
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Primer Nombre',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .firstName ==
                                                  ""
                                              ? 'No Registra'
                                              : widget.registerSelect.driver!
                                                  .firstName,
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Segundo Nombre',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .secondName ==
                                                  ""
                                              ? 'No Registra'
                                              : widget.registerSelect.driver!
                                                  .secondName,
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Primer Apellido',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .firstSurname ==
                                                  ""
                                              ? 'No Registra'
                                              : widget.registerSelect.driver!
                                                  .firstSurname,
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Segundo Apellido',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!
                                                      .secondSurname ==
                                                  ""
                                              ? 'No Registra'
                                              : widget.registerSelect.driver!
                                                  .secondSurname,
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Telefono',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.registerSelect.driver!.phone ==
                                                  0
                                              ? 'No Registra'
                                              : widget
                                                  .registerSelect.driver!.phone
                                                  .toString(),
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tiempo Trasncurrido',
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Hora',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${widget.registerSelect.hourElapsed}',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Min',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${widget.registerSelect.minElapsed}',
                                          style: GoogleFonts.lato(
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Valor Parking',
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      '${widget.registerSelect.dolar > 1 ? widget.registerSelect.dolar.toString() + " DOLARES" : widget.registerSelect.dolar.toString() + " DOLAR"} Y  ${widget.registerSelect.pennies > 1 ? widget.registerSelect.pennies.toString() + " CENTAVOS" : widget.registerSelect.pennies.toString() + " CENTAVO"}',
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                onPressed: () async {
                                  final deletesucces = await alertConfirm(
                                      context,
                                      title: 'Eliminar',
                                      icono: Icons.delete,
                                      content: Text(
                                          '¿Seguro desea realizar esta accion?, el dato se eliminara de forma permanente'),
                                      colorIcono: Colors.red,
                                      colorHeader: Colors.red,
                                      op: 1,
                                      indexPage: 1,
                                      idItem: widget.registerSelect.id);
                                  if (deletesucces) Navigator.pop(context);
                                },
                                child: Text('Eliminar Registro',
                                    style:
                                        GoogleFonts.lato(color: Colors.white)))
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: 30),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Vehiculo',
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: inputComponent(
                                              autofocus:
                                                  widget.isEdit ? false : true,
                                              enableb:
                                                  widget.isEdit ? false : true,
                                              contentPadding: EdgeInsets.all(5),
                                              format: [Util.maskFormatter],
                                              focusNode: DriverG.enrollment,
                                              onSubmitted: (ons) {
                                                DriverG.identificationCard
                                                    .requestFocus();
                                              },
                                              style: 1,
                                              controller:
                                                  Util.enrollmentController,
                                              icono: Icons.pin_rounded,
                                              label: 'Placa del Vehiculo*'),
                                        ),
                                      ],
                                    ),
                                    StoreProvider<Uint8List?>(
                                        store: reduxByteImage,
                                        child: StoreConnector<Uint8List?,
                                                dynamic>(
                                            converter: (reduxByteImage) =>
                                                reduxByteImage.state,
                                            builder: (context, byteImageS) =>
                                                InkWell(
                                                  onTap: () {
                                                     return alertConfirm(context,
                                                        title: 'Tomar Foto',
                                                        content: Text(
                                                            'Para tomar la foto de forma correcta ubique el dispositovo de forma horizontal',
                                                            style: GoogleFonts
                                                                .lato()),
                                                        indexPage: 0,
                                                        idItem: true,
                                                        colorHeader:
                                                            Colors.blue,
                                                        colorIcono: Colors.blue,
                                                        icono: Icons
                                                            .add_a_photo_rounded);
                                                  },
                                                  child: Container(
                                                    width: 120,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    padding:  byteImageS == null
                                                        ?
                                                        EdgeInsets.all(15):EdgeInsets.all(0),
                                                    child: byteImageS == null
                                                        ? Icon(
                                                            Icons
                                                                .add_a_photo_rounded,
                                                            color: Colors.grey)
                                                        : Container(
                                                            width: 120,
                                                            height: 70,
                                                            child: Image.memory(
                                                              byteImageS,
                                                              width: 120,
                                                              height: 70,
                                                            ),
                                                          ),
                                                  ),
                                                ))),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Conductor',
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          widget.itemDriver == null
                                              ? 'Conductor no registrado'
                                              : widget.itemDriver.driverName ==
                                                      ""
                                                  ? 'Conductor no registrado'
                                                  : widget
                                                      .itemDriver.driverName,
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    inputComponent(
                                        style: 1,
                                        contentPadding: EdgeInsets.all(5),
                                        focusNode: DriverG.identificationCard,
                                        controller: DriverG
                                            .identificationCardController,
                                        onSubmitted: (onsu) {
                                          DriverG.firstName.requestFocus();
                                        },
                                        type: TextInputType.number,
                                        format: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        icono: Icons.badge_rounded,
                                        label: 'Numero Identificacion*'),
                                    SizedBox(height: 10),
                                    inputComponent(
                                        style: 1,
                                        contentPadding: EdgeInsets.all(5),
                                        focusNode: DriverG.firstName,
                                        controller: DriverG.firstNameController,
                                        onSubmitted: (ons) {
                                          DriverG.secondName.requestFocus();
                                        },
                                        icono: Icons.account_circle_rounded,
                                        label: 'Primer Nombre*'),
                                    inputComponent(
                                        style: 1,
                                        contentPadding: EdgeInsets.all(5),
                                        focusNode: DriverG.secondName,
                                        controller:
                                            DriverG.secondNameController,
                                        onSubmitted: (ons) {
                                          DriverG.firstSurname.requestFocus();
                                        },
                                        icono: Icons.account_circle_rounded,
                                        label: 'Segundo Nombre (Opcional)'),
                                    inputComponent(
                                        style: 1,
                                        contentPadding: EdgeInsets.all(5),
                                        focusNode: DriverG.firstSurname,
                                        controller:
                                            DriverG.firstSurnameController,
                                        onSubmitted: (ons) {
                                          DriverG.secondSurname.requestFocus();
                                        },
                                        icono: Icons.switch_account_rounded,
                                        label: 'Primer Apellido*'),
                                    inputComponent(
                                        style: 1,
                                        contentPadding: EdgeInsets.all(5),
                                        focusNode: DriverG.secondSurname,
                                        controller:
                                            DriverG.secondSurnameController,
                                        onSubmitted: (ons) {
                                          DriverG.phone.requestFocus();
                                        },
                                        icono: Icons.switch_account_rounded,
                                        label: 'Segundo Apellido (Opcional)'),
                                    inputComponent(
                                        type: TextInputType.number,
                                        format: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        style: 1,
                                        onSubmitted: (onsu) {
                                          if (widget.isEdit) {
                                            DriverG.registerAndEditDrivers(
                                                context,
                                                isEdit: true,
                                                itemDriver: widget.itemDriver);
                                          } else {
                                            DriverG.registerAndEditDrivers(
                                                context);
                                          }
                                        },
                                        controller: DriverG.phoneController,
                                        focusNode: DriverG.phone,
                                        contentPadding: EdgeInsets.all(5),
                                        icono: Icons.phone_rounded,
                                        label: 'Telefono (Opcional)')
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        widget.isEdit
                                            ? Colors.orangeAccent
                                            : Colors.blue)),
                                onPressed: () async {
                                  if (widget.isEdit) {
                                    DriverG.registerAndEditDrivers(context,
                                        isEdit: true,
                                        itemDriver: widget.itemDriver);
                                  } else {
                                    DriverG.registerAndEditDrivers(context);
                                  }
                                },
                                child: Text(
                                    widget.isEdit
                                        ? 'Editar Conductor'
                                        : 'Registrar Conductor',
                                    style:
                                        GoogleFonts.lato(color: Colors.white)))
                          ],
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
