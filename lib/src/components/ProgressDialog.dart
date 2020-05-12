import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProgressDialog {

  static bool isLoading = false;

  static Future showLoading(BuildContext context) {
    isLoading = true;
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoActivityIndicator(animating: true,);
        }
      );
    }
    return showDialog(
      context: context,
      builder: (_) {
        return CircularProgressIndicator();
      }
    );
  }

  static void hideLoading(BuildContext context) {
    if (isLoading) {
      Navigator.pop(context);
      isLoading = false;
    } 
  }

}