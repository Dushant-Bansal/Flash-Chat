import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Hint Text',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFAF4CF), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFAF4CF), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Oxanium',
  fontWeight: FontWeight.bold,
);

const kTitleStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'PatrickHand',
  letterSpacing: 2.5,
  color: Colors.white,
  decoration: TextDecoration.none,
);

const kErrorStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.normal,
  decoration: TextDecoration.none,
  fontSize: 16.0,
);

const kSpinkit = SpinKitDoubleBounce(
  color: Colors.white,
  size: 50.0,
);
