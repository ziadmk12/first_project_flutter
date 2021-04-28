import 'package:flutter/material.dart';

validinput(String val, int max, int min, String type) {
  if (val.trim().length > max) {
    return '$type should not be less than $max lettre';
  }

  if (val.trim().length < min) {
    return '$type should not be less than $min lettre';
  }

  if (val.trim().isEmpty) {
    return '$type should not be impty';
  }
}

validEmail(String val, int max, int min, String type) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  if (val.trim().length > max) {
    return '$type should not be less than $max lettre';
  }

  if (val.trim().length < min) {
    return '$type should not be less than $min lettre';
  }

  if (val.trim().isEmpty) {
    return '$type should not be impty';
  }

  RegExp regExp = new RegExp(pattern);
  if (!regExp.hasMatch(val)) {
    return '$type form not match (exemple@gmail.com)';
  }
}

confirmPassword(String val, int max, int min, String type, String password) {
  if (val.trim().length > max) {
    return '$type should not be less than $max lettre';
  }

  if (val.trim().length < min) {
    return '$type should not be less than $min lettre';
  }

  if (val.trim().isEmpty) {
    return '$type should not be impty';
  }
  if (val != password) {
    return '$type not match';
  }
}
