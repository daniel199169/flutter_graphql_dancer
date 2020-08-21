import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dancer/graphql/private.dart' as gql;
import 'package:dancer/widgets/fade_transition.dart';
import 'package:dancer/screens/private/check_in_wrapper.dart';

class CheckInQRScan extends StatefulWidget {
  @override
  _CheckInQRScanState createState() => _CheckInQRScanState();
}

class _CheckInQRScanState extends State<CheckInQRScan> {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String text = '';

  void submitCheckIn(int eventId) async {
    String msg = "";
    bool checked = false;
    bool close = false;
    final r = await gql.Private.checkIn(eventId);
    if (r.hasException) {
      print("QR submit error: ${r.exception.graphqlErrors[0].message}");
      final error = r.exception.graphqlErrors[0].message;
      if (error == "ALREADY_CHECKED_IN") {
          msg = "Already checked in!";
          close = true;
      } else {
          msg = "Error submiting, try again.";
      }
    } else {
      checked = r.data["eventCheckIn"] as bool;
      if (checked) {
        msg = "Successfully checked in!";
        close = true;
      } else {
        msg = "Error submiting, try again.";
      }
    }

    setState(() {
      text = msg;
    });

    if (close || checked) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        controller.pauseCamera();
        Navigator.push(context, FadeRoute(page: CheckInWrapper()));
      });
    }
  }

  //function that launches the scanner
  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      text = '';
    });
    this.controller = controller;
    controller.scannedDataStream.listen((data) {
      // EDC:eventId=2
      print("qr data: $data");
      if (!data.startsWith("EDC:")) {
        print("wrong prefix");
        return;
      }

      final tokens = data.substring(4).split("=");
      if (tokens[0] == "eventId") {
        final eventId = int.parse(tokens[1]);
        submitCheckIn(eventId);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          SizedBox(height: 20),
          /*RaisedButton(
            color: Color(0xffDFC494),
            child: Text(
              'Click To Scan',
              style: TextStyle(color: Colors.black),
            ),
            //onPressed: scanQRCode,
          ),*/
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
