import 'package:MyTravelPlan/src/bloc/auth/Auth.dart';
import 'package:MyTravelPlan/src/components/CustomDialog.dart';
import 'package:MyTravelPlan/src/components/PTextField.dart';
import 'package:MyTravelPlan/src/components/ProgressDialog.dart';
import 'package:MyTravelPlan/src/constants/ColorConstant.dart';
import 'package:MyTravelPlan/src/constants/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final AuthBloc _authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();

    _authBloc.listen((currentState) {
      if (currentState is AuthSuccessState) {
        throw UnimplementedError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authBloc,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  strLogin,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                _inputContainer()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: const Color(0x14D8D8D8),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFF979797))),
      child: Column(
        children: <Widget>[
          PTextField(
            titleLabel: strUsername,
            placeholder: strInputUsername,
            keyboardType: TextInputType.emailAddress,
            controller: this._usernameTextController,
          ),
          PTextField(
            titleLabel: strPassword,
            placeholder: strInputPassword,
            secureEntry: true,
            controller: this._passwordTextController,
          ),
          FlatButton(
            child: Container(
              width: double.infinity,
              child: Text(
                strForgotPassword,
                textAlign: TextAlign.end,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            textColor: colorDefaultButton,
            onPressed: () {
              CustomDialog.showMessage(context: context, content: 'Opening Forgot Password ...');
            },
          ),
          FlatButton(
            child: Container(
              width: 150,
              child: Text(
                strLogin,
                textAlign: TextAlign.center,
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
            ),
            textColor: Colors.white,
            color: colorDefaultButton,
            onPressed: () {
              ProgressDialog.hideLoading(context);
              // this._authBloc.dispatch(AuthLoginEvent(
              //     username: this._usernameTextController.text,
              //     password: this._passwordTextController.text));
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    this._usernameTextController.dispose();
    this._passwordTextController.dispose();
    super.dispose();
  }

}
