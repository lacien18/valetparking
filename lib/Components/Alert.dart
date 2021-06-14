import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valetparking/Global/CarsG.dart' as Cars;
import 'package:valetparking/Global/DriversG.dart' as DriverG;
import 'package:valetparking/Global/RegistersG.dart' as RegisterG;
import 'package:valetparking/Global/RegistersG.dart';
import 'package:valetparking/Global/Util.dart' as Util;
import 'package:valetparking/Redux/AllStates.dart';

import 'DetailAndDriverRegister.dart';

FToast ftoast = FToast();

toastContext(
  BuildContext context, {
  text: "toast",
  colorTexto = Colors.white,
  colorFondo = Colors.green,
  duration = 5,
  toasboton = false,
}) {
  ftoast.init(context);
  Widget toast = Card(
    shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 30,
      color: colorFondo,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
              color: colorTexto, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ));
  ftoast.showToast(
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: duration),
  );
}

 alertComponent(
  BuildContext context, {
  title,
  content,
  colorHeader,
  icono,
  colorBoton,
  colorBotonText,
  colorIcono,
  isEdit = false,
  op,
  itemSelect,
  idParking,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icono != null ? Icon(icono, color: colorIcono) : SizedBox.shrink(),
            icono != null ? SizedBox(width: 2) : SizedBox.shrink(),
            Text(title, style: TextStyle(color: colorHeader)),
          ],
        ),
        content: content,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: Icon(Icons.close),
                  label: Text('Cancelar', style: TextStyle())),
              SizedBox(width: 10),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          isEdit ? Colors.orangeAccent : Colors.blue)),
                  onPressed: () async {
                    switch (op) {
                      case 2:
                        switch (isEdit) {
                          case false:
                          if(Util.enrollmentController.text.length == 7){
                            Cars.registerCars(context,idParking);
                          Navigator.pop(context, true);
                          }else{
                           return toastContext(context,
                                text: 'Faltan letras/numeros de la placa',
                                colorFondo: Colors.red,
                                duration: 3);
                          }
                            break;
                          case true:
                            final close =
                                await Cars.editCars(context, itemSelect);
                            if (close) Navigator.pop(context, true);
                            break;
                        }
                        break;
                    }
                  },
                  icon: Icon(Icons.check),
                  label:
                      Text(isEdit ? 'Editar' : 'Registrar', style: TextStyle()))
            ],
          )
        ],
      );
    },
  );
}

alertConfirm(
  BuildContext context, {
  idItem,
  indexPage,
  op,
  title,
  content,
  colorHeader,
  icono,
  colorBoton,
  colorBotonText,
  colorIcono,
  register,
   idParking,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Row(
          children: <Widget>[
            Icon(icono, color: colorIcono),
            SizedBox(width: 2),
            Text(title, style: GoogleFonts.lato(color: colorHeader)),
          ],
        ),
        content: content,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(op == 3?Colors.green:Colors.red)),
                onPressed: () async{
                  Util.byteImage = null;
      reduxByteImage.dispatch(AccionsByteImage.UpdateByteImage);
                  Navigator.pop(context, false);
                  if(op == 3){
               final item =await   updateDriver(idItem.driver.id,
                        idItem.id);
                    await Navigator.push(
                      context,
                      MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return DetailAndDriverRegister(
                            registerSelect: item,
                            op: 1,
                            isEdit: false,
                          );
                        },
                        fullscreenDialog: true,
                      ),
                    );
                  }
                },
                icon: Icon(op == 3?Icons.visibility_rounded:Icons.close_rounded),
                label: Text(op == 3?'Ver Detalles':
                  'Cancelar',
                   style: GoogleFonts.lato()
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  switch (indexPage) {
                     case 0:
                     Util.openCamera(context,close: idItem);
                      break;
                    case 1:
                      switch (op) {
                        case 1:
                          Navigator.pop(context, true);
                          RegisterG.deleteRegister(context,idItem);
                          break;
                      }
                      break;
                    case 2:
                      switch (op) {
                        case 1:
                          Navigator.pop(context, true);
                          await Cars.deleteCars(context,idItem,idParking);
                          break;
                        case 2:
                          Navigator.pop(context, true);
                          Cars.editCars(context, idItem);
                          break;
                        case 3:
                          Navigator.pop(context, true);
                          break;
                      }
                      break;
                    case 3:
                      switch (op) {
                        case 1:
                          Navigator.pop(context, true);
                          DriverG.deleteDriver(context, idItem);
                          break;
                      }
                      break;
                  }
                },
                icon: Icon(Icons.check),
                label: Text(
                  'Continuar',
                   style: GoogleFonts.lato()
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
