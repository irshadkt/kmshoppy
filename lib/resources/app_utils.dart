import 'package:flutter/material.dart';
Widget appLoading({double? value}) {
  return CircularProgressIndicator(
    value: value,
    color: Colors.white,
    backgroundColor: Colors.redAccent,
  );
}