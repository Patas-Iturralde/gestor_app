import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class alertaProgreso {
  alertas1(BuildContext context, titulo, contenido) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: 'asfadf',
      autoCloseDuration: const Duration(seconds: 2),
      showConfirmBtn: false,
      title: 'vcv',
    );
  }

  progreso(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  alertas(context, titulo, contenido, tipo) {
    QuickAlertType tpoBtn = QuickAlertType.error;
    Color colorBtn = Colors.red;
    if (tipo == 2) {
      tpoBtn = QuickAlertType.success;
      colorBtn = Colors.green;
    }
    QuickAlert.show(
      context: context,
      type: tpoBtn,
      text: contenido.toString(),
      title: titulo.toString(),
      confirmBtnText: 'Ok',
      confirmBtnColor: colorBtn,
    );
    /*
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              title: Text(titulo.toString()),
              content: Text(contenido.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                )
              ],
            ),
          );
        });*/
  }
}
