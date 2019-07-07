import 'package:flutter/material.dart';

import 'ui/screens/login.dart';

//Credits
//Design inspired from Anastasia Marinicheva on Dribbble
//Photo of ice cream by ian dooley on Unsplash
//Photo by Sharon McCutcheon from Pexels

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginScreen(),
    );
  }
}
