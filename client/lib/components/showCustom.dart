import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustom(BuildContext context, var type) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: type == 'login' ? Colors.redAccent : Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        txt(type)
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM);
}

Text txt(String t) {
  switch (t) {
    case 'Edit':
      return Text("Supervisor Edited successfully");
      break;
    case 'delete':
      return Text("Supervisor deleted successfully");
      break;
    case 'login':
      return Text("Email or password wrong !");
      break;
    case 'deleteI':
      return Text("Intern deleted successfully ");
      break;
    default:
      return Text("Supervisor added successfully");
  }
}
