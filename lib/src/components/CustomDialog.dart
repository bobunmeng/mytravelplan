import 'dart:io';
import 'package:MyTravelPlan/src/constants/ColorConstant.dart';
import 'package:MyTravelPlan/src/constants/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  /// Display alert dialog with 2 buttons (OK, Cancel => as default)
  static Future show(
      {@required BuildContext context,
      String title = '',
      @required String content,
      String positiveButtonTitle,
      Function positiveAction,
      String negativeButtonTitle,
      Function negativeAction}) async {
    final pAction = positiveAction ?? () => Navigator.pop(context);
    final nAction = negativeAction ?? () => Navigator.pop(context);

    Widget dialog = _buildDialog(
        title: title,
        content: content,
        positiveButtonTitle: positiveButtonTitle,
        positiveAction: pAction,
        negativeButtonTitle: negativeButtonTitle,
        negativeAction: nAction);
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return dialog;
          });
      return;
    }
    showDialog(
        context: context,
        builder: (_) {
          return dialog;
        });
  }

  /// Display alert dialog with one button (OK => as default)
  /// If isErrorMessage, the text displays Red
  static Future showMessage(
      {@required BuildContext context,
      String title = '',
      @required String content,
      String buttonTitle,
      Function buttonAction,
      bool isErrorMessage = false}) async {
    final bAction = buttonAction ?? () => Navigator.pop(context);
    Widget dialog = _buildDialogMessage(
        title: title,
        content: content,
        buttonTitle: buttonTitle,
        buttonAction: bAction,
        isErrorMessage: isErrorMessage);
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return dialog;
          });
      return;
    }
    showDialog(
        context: context,
        builder: (_) {
          return dialog;
        });
  }

  static Widget _buildDialog(
      {String title = '',
      @required String content,
      String positiveButtonTitle,
      Function positiveAction,
      String negativeButtonTitle,
      Function negativeAction}) {
    final buttons = _dialogButtons(
        positiveTitle: positiveButtonTitle,
        positiveAction: positiveAction,
        negativeTitle: negativeButtonTitle,
        negativeAction: negativeAction);

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: _dialogContent(content),
        actions: buttons,
      );
    }

    return AlertDialog(
      title: Text(title),
      content: _dialogContent(content),
      actions: buttons,
    );
  }

  static Widget _buildDialogMessage(
      {String title = '',
      @required String content,
      String buttonTitle,
      Function buttonAction,
      bool isErrorMessage = false}) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: _dialogContent(content, isErrorMessage: isErrorMessage),
        actions: <Widget>[
          _dialogButton(buttonTitle: buttonTitle, buttonAction: buttonAction)
        ],
      );
    }
    return AlertDialog(
      title: Text(title),
      content: _dialogContent(content, isErrorMessage: isErrorMessage),
      actions: <Widget>[
        _dialogButton(buttonTitle: buttonTitle, buttonAction: buttonAction)
      ],
    );
  }

  static Widget _dialogButton({String buttonTitle, Function buttonAction}) {
    if (Platform.isIOS) {
      return CupertinoButton(
          child: _dialogButtonText(buttonTitle ?? strOk),
          onPressed: buttonAction);
    }
    return FlatButton(
      child: _dialogButtonText(buttonTitle ?? strOk),
      onPressed: buttonAction,
    );
  }

  static List<Widget> _dialogButtons(
      {String positiveTitle,
      Function positiveAction,
      String negativeTitle,
      Function negativeAction}) {
    final pTitle = positiveTitle ?? strOk;
    final nTitle = negativeTitle ?? strCancel;

    if (Platform.isIOS) {
      return [
        CupertinoButton(
          child: _dialogButtonText(pTitle),
          onPressed: positiveAction,
        ),
        CupertinoButton(
          child: _dialogButtonText(nTitle),
          onPressed: negativeAction,
        ),
      ];
    }

    return [
      FlatButton(
        child: _dialogButtonText(pTitle),
        onPressed: positiveAction,
      ),
      FlatButton(
        child: _dialogButtonText(nTitle),
        onPressed: negativeAction,
      )
    ];
  }

  static Widget _dialogButtonText(String title) {
    return Text(
      title,
      style: TextStyle(color: colorDefaultButton),
    );
  }

  static Widget _dialogContent(String content, {bool isErrorMessage = false}) {
    final style = isErrorMessage
        ? TextStyle(fontSize: 16.0, color: Colors.red)
        : TextStyle(fontSize: 16.0);
    return Text(content, style: style);
  }

  /// Show select list dialog
  /// Choices and Actions must be the same length
  static Future showAlertSheet(
      {BuildContext context,
      String title = '',
      String message,
      List<String> choices,
      List<Function> actions}) {
    List<CupertinoActionSheetAction> iOSActions = [];
    choices.asMap().forEach((index, choice) {
      iOSActions.add(CupertinoActionSheetAction(
        child: Text(choice),
        onPressed: actions[index]
      ));
    });

    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(title.isEmpty ? strChoices : title),
          message: message == null ? message : Text(message),
          actions: iOSActions,
          cancelButton: CupertinoActionSheetAction(
            child: const Text(strCancel),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, strCancel);
            },
          )),
    );
  }
}
