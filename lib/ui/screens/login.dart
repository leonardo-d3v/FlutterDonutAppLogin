import 'package:fl_donut_app_login/ui/widgets/ui_elements/animated_fab.dart';
import 'package:fl_donut_app_login/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const double borderRadius = 60.0;
  bool passwordVisible = false;

  InputDecoration _buildPasswordFieldDecoration() {
    return InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: accentColor),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ));
  }

  _bottomActionsStyles() {
    return TextStyle(
      fontSize: 16,
      color: accentColor,
      decoration: TextDecoration.underline,
    );
  }

  Widget _buildFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          child: Text(
            "Please Sign In",
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Email',
          ),
        ),
        TextFormField(
          obscureText: passwordVisible,
          decoration: _buildPasswordFieldDecoration(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Forgot password?",
                style: _bottomActionsStyles(),
              ),
              Text(
                "Sign up",
                style: _bottomActionsStyles(),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    Widget _buildLoginForm() {
      return Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 36),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius)),
                  color: Colors.white),
              child: _buildFields(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: AnimatedFab(
              onTap: () {},
              icon1: Icons.arrow_forward,
              icon2: Icons.close,
              fabColor: primaryColor,
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset(
            'assets/images/background_donut.jpg',
            fit: BoxFit.cover,
            height: screenSize.height,
            width: screenSize.width,
          ),
          _buildLoginForm()
        ],
      ),
    );
  }
}
