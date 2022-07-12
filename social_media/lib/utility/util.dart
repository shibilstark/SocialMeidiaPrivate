import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/core/colors/colors.dart';

class Util {
  static showSimpleDialogue(
      {required BuildContext context, required String message}) async {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"))
              ],
            ));
  }

  static showLoadingDialogue({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Center(
                  child: CircularProgressIndicator(
                color: primary,
              )),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                  ],
                )
              ],
            ));
  }

  static showToast({required String message}) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM);
  }

  // static showRouteReplacingDialogueToLogin({
  //   required BuildContext context,
  //   required String message,
  // }) {
  //   showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //             content: Text(message),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pushReplacementNamed("/");
  //                   },
  //                   child: Text("Let's go"))
  //             ],
  //           ));
  // }

  static showCoolAlertFromSignUpToLogin({
    required BuildContext context,
    required CoolAlertType type,
    required String okString,
    required String text,
    // String text = "",
  }) {
    CoolAlert.show(
        backgroundColor: primary,
        context: context,
        type: type,
        text: text == "" ? null : text,
        confirmBtnText: okString,
        // title: title,
        onConfirmBtnTap: () {
          if (type == CoolAlertType.success) {
            Navigator.of(context).pushReplacementNamed("/login");
          } else {
            Navigator.of(context).pop();
          }
        });
  }

  static showNormalCoolAlerr({
    required BuildContext context,
    required CoolAlertType type,
    required String okString,
    required String text,
    // String text = "",
  }) {
    CoolAlert.show(
      backgroundColor: primary,
      context: context,
      type: type,
      text: text == "" ? null : text,
      confirmBtnText: okString,
      // title: title,
    );
  }

  static showLogoutCoolAlert({
    required BuildContext context,
    required CoolAlertType type,
    required String okString,
    required String text,
    // String text = "",
  }) async {
    await CoolAlert.show(
        showCancelBtn: true,
        backgroundColor: primary,
        context: context,
        type: type,
        text: text == "" ? null : text,
        confirmBtnText: okString,
        onConfirmBtnTap: () =>
            Navigator.of(context).pushReplacementNamed("/login"));
    Fluttertoast.showToast(msg: "Logged Out Seccessfully");
  }
}
