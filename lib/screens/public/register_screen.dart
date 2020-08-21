import 'package:dancer/widgets/dancer_datepicker_service.dart';
import 'package:dancer/widgets/dancer_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dancer/widgets/fade_transition.dart';
import 'package:dancer/screens/private/home_wrapper.dart';
import 'package:dancer/graphql/public.dart' as gql;
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/graphql/models/user.dart';
import 'package:dancer/globals.dart' as globals;

class RegisterScreen extends StatefulWidget {
  final Function stateChange;

  RegisterScreen({this.stateChange});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  DateTime _birthDate;

  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isMarketingEmailSelected = false;
  bool _showPicker = false;

  String _title,
      _firstName,
      _lastName,
      _email,
      _phoneNumber,
      _password,
      _selectedTitle,
      _dob;

  String errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black, //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
      )
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/icons/logo_avatar.png', fit: BoxFit.cover),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      _getFormSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSaved(String value, String label) {
    if (label.isNotEmpty) {
      if (label == "Title") {
        _title = value;
      } else if (label == "First Name") {
        _firstName = value;
      } else if (label == "Last Name") {
        _lastName = value;
      } else if (label == "Email") {
        _email = value;
      } else if (label == "Phone") {
        _phoneNumber = value;
      } else if (label == "Password") {
        _password = value;
      } else if (label == "DOB") {
        _password = value;
      } else {
        // Should not be here!!
      }
    } else {
      // Should not be here
    }
  }

  void _proceed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    /*if (!_rememberMe) {
      return;
    }*/

    _formKey.currentState.save();

    print("login 1");
    var r = await gql.Public.login(_phoneNumber, _password);
    print("login 2");
    if (r.hasException) {
      print("login error: ${r.exception}");

      final msg = r.exception.graphqlErrors[0].message;
      if (msg == "PHONE_PASSWORD_MISSMATCH") {
        setState(() {
          errorMessage = "Phone/password mismatch";
        });
      } else {
        setState(() {
          //errorMessage = null;
        });
      }
      gql.Public.resetCache();
      return;
    }

    if (r.data == null) {
      print("phone/password mismatch");
      return;
    }

    gql.Private.token = r.data["login"]["token"];
    print("token: ${gql.Private.token}");

    globals.USER = User.fromJson(r.data["login"]["user"]);

    Navigator.push(context, FadeRoute(page: HomeWrapper()));
  }

  Widget _getFormSection(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final errorWidget = errorMessage != null ? Center(child: Text(errorMessage, style: TextStyle(fontSize: 16, color: Colors.red))) : Container();

    return Form(
      key: _formKey,
      child: Container(
        height: height,
        child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              DancerTextField(
                controller: null,
                isSecret: false,
                maxLine: 1,
                labelText: "Phone",
                onSaved: (String value) {
                  _onSaved(value, 'Phone');
                },
                validator: _fieldValidator,
              ),
              DancerTextField(
                controller: null,
                maxLine: 1,
                isSecret: true,
                labelText: "Password",
                onSaved: (String value) {
                  _onSaved(value, 'Password');
                },
                validator: _fieldValidator,
              ),
              SizedBox(height: 20),
              errorWidget,
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    print("here 1");
                    _proceed();
                  },
                  color: Color(0xffBD8929),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
              ),
            ],
          ),
          /*_showPicker
              ? Positioned(
                  top: height * 0.3,
                  bottom: height * 0.2,
                  left: 1,
                  right: 1,
                  child: DancerDatepickerService(
                    onClose: _onClose,
                    onSet: _onSet,
                    initDate: DateTime.now(),
                    maxDate: DateTime.now(),
                  ))
              : SizedBox.shrink(),*/
        ],
      ),
      ),
    );
  }

  String _fieldValidator(String value) {
    if (value.isEmpty) {
      return "Mandatory Field";
    }
    return null;
  }

  _onSet(DateTime selectedDate) {
    print('_onExpirySet');
    if (selectedDate == null) {
    } else {
      _birthDate = selectedDate;
      _dob = "${_birthDate.day}/${_birthDate.month}/${_birthDate.year}";
      _dobController.text = _dob;
    }

    setState(() {
      _showPicker = false;
    });
  }

  _onClose(DateTime selectedDate) {
    print('_onExpiryClose');
    if (selectedDate == null) {
    } else {
      _birthDate = null;
      _dob = "";
      _dobController.text = _dob;
    }

    setState(() {
      _showPicker = false;
    });
  }
}
