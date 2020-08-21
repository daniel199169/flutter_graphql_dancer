
Function between(int min, int max) {
  return (String value) {
    if (value.length < min || value.length > max) {
      return 'Must be between $min and $max characters';
    }
    return null;
  };
}

Function required() {
  return (String value) {
    if (value.trim().isNotEmpty) {
      return null;
    }
    return 'Required';
  };
}

Function email({bool require=true}) {
  return (String value) {
    String result;
    if (require) {
      result = required()(value);
      if (result != null) {
        return result;
      }
    }
    result = between(3, 100)(value);
    if (result != null) {
      return result;
    }
    const Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(value)) ? null : 'Not a valid email';
  };
}

Function password() {
  return (String value) {
    var result = required()(value);
    if (result != null) {
      return result;
    }
    return between(6, 100)(value);
  };
}

Function phone({bool require=true}) {
  // TODO: check only numbers
  return (String value) {
    String result;
    if (require) {
      result = required()(value);
      if (result != null) {
        return result;
      }
    }
    return between(3, 30)(value);
  };
}

Function items({String pattern=' ', int count}) {
  return (String value) {
    final list = value.trim().split(pattern);
    if (list.length >= count) {
      return null;
    }
    return 'Must contain at least $count items';
  };
}