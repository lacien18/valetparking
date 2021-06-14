import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Components/Input.dart';
import 'package:valetparking/Global/DriversG.dart';
import 'package:valetparking/Global/Util.dart' as Util;

class CreatEditDrivers extends StatefulWidget {
  final bool isEdit;
  const CreatEditDrivers({Key? key,required this.isEdit}) : super(key: key);

  @override
  _CreatEditDriversState createState() => _CreatEditDriversState();
}

class _CreatEditDriversState extends State<CreatEditDrivers> {
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
                  SizedBox(height: 25),
                  Text('Registrar Conductor',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputComponent(
                          style: 1,
                            contentPadding: EdgeInsets.all(0),
                            autofocus: true,
                            controller: identificationCardController,
                            onSubmitted: (ons) {
                              firstName.requestFocus();
                            },
                            icono: Icons.schedule_outlined,
                            format: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[.0-9]'))
                            ],
                            label: 'Numero Identificacion*'),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          child: inputComponent(
                              contentPadding: EdgeInsets.all(0),
                              focusNode: firstName,
                              controller: firstNameController,
                              onSubmitted: (ons) {
                                secondName.requestFocus();
                              },
                              icono: Icons.airline_seat_recline_normal_rounded,
                              label: 'Primer Nombre*'),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          child: inputComponent(
                              contentPadding: EdgeInsets.all(0),
                              focusNode: secondName,
                              controller: secondNameController,
                              onSubmitted: (ons) {
                                firstSurname.requestFocus();
                              },
                              icono: Icons.airline_seat_recline_normal_rounded,
                              label: 'Segundo Nombre'),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          child: inputComponent(
                              contentPadding: EdgeInsets.all(0),
                              focusNode: firstSurname,
                              controller: firstSurnameController,
                              onSubmitted: (ons) {
                                secondSurname.requestFocus();
                              },
                              icono: Icons.schedule_outlined,
                              label: 'Primer Apellido*'),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          child: inputComponent(
                              contentPadding: EdgeInsets.all(0),
                              focusNode: secondSurname,
                              controller: secondSurnameController,
                              onSubmitted: (ons) {
                                enrollment.requestFocus();
                              },
                              icono: Icons.schedule_outlined,
                              label: 'Segundo Apellido'),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10),
                              child: inputComponent(
                                  contentPadding: EdgeInsets.all(0),
                                  format: [Util.maskFormatter],
                                  focusNode: enrollment,
                                  onSubmitted: (ons) {
                                    phone.requestFocus();
                                  },
                                  controller: Util.enrollmentController,
                                  icono: Icons.pin_rounded,
                                  label: 'Placa del Vehiculo*'),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10),
                              child: inputComponent(
                                  onSubmitted: (onsu) {
                                    registerAndEditDrivers(context);
                                  },
                                  format: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[.0-9]'))
                                  ],
                                  controller: phoneController,
                                  focusNode: phone,
                                  contentPadding: EdgeInsets.all(0),
                                  icono: Icons.phone_rounded,
                                  label: 'Telefono'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(

                        onPressed: () {
                          registerAndEditDrivers(context);
                        },
                        label: Text(
                          'Registrar',
                          style: GoogleFonts.lato(),
                        ),
                        icon: Icon(Icons.check_rounded),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
