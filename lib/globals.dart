library globals;

import 'package:flutter/material.dart';
import 'package:dancer/graphql/models/user.dart';

final API_URI = "http://88.99.243.34:40000";

User USER;

String TOKEN;


String mapValidators(String value, List<Function(String)> validators) {
  if (validators == null) {
    return null;
  }
  for (var validator in validators) {
    if (validator == null) {
      continue;
    }
    final result = validator(value);
    if (result != null) {
      return result;
    }
  }
  return null;
}
