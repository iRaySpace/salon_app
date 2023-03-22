import 'package:flutter/material.dart';
import 'package:salon_app/data/auth_repository.dart';

showAlertDialog({
  required BuildContext context,
  required String titleText,
  required String contentText,
  required Function()? onContinue,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text("Cancel"),
  );

  Widget continueButton = TextButton(
    onPressed: onContinue,
    child: const Text("Continue"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(titleText),
    content: Text(contentText),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLogoutDialog(BuildContext context, Function() onContinue) {
  showAlertDialog(
    context: context,
    titleText: 'Logout',
    contentText: 'You would like to continue logging out from the system?',
    onContinue: () async {
      await AuthRepository().logout();
      onContinue();
    },
  );
}
