import 'package:flutter/material.dart';
import 'package:flutter_app/pages/boycotted_page.dart';
import 'package:flutter_app/pages/notBoycotted_page.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class BarCodeScanner extends StatefulWidget {
  @override
  _BarCodeScannerState createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  bool isProcessing = false; // Pour éviter le traitement multiple des résultats

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display an image
            Image.asset(
              'assets/images/3.png', // Replace with your image path
              width: 200, // Set width as needed
              height: 200, // Set height as needed
            ),
            SizedBox(height: 20), // Spacing between image and text
            Text(
              'Scan the Barcode Below',
              style: TextStyle(
                fontSize: 24, // Font size of the phrase
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40), // Spacing before the scanner action
            GestureDetector(
              onTap: () async {
                if (!isProcessing) {
                  setState(() {
                    isProcessing = true;
                  });

                  final String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                    '#FF6666', // Color of the scan line
                    'Cancel', // Cancel button text
                    true, // Whether to show the flash icon
                    ScanMode.BARCODE, // Set scan mode to Barcode
                  );

                  if (barcodeScanRes != '-1') {
                    // Si l'utilisateur ne clique pas sur Annuler
                    _processResult(barcodeScanRes);
                  }

                  setState(() {
                    isProcessing = false;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF09FBD3), Colors.redAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Text(
                  'Tap to Scan',
                  style: TextStyle(
                    fontSize: 18, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour traiter le résultat scanné
  Future<void> _processResult(String codeBarre) async {
    final String apiUrl =
        'http://192.168.1.14:8080/api/produits/check?codeBarre=$codeBarre';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print(response.body);
        final bool isBoycotted = response.body == 'true';

        if (isBoycotted) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => boycotted()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => notboycotted()));
        }
      } else {
        // Gérer les erreurs de réponse
        _showDialog(
          title: 'Error',
          content: 'Failed to fetch product info.',
        );
      }
    } catch (e) {
      // Gérer les exceptions
      _showDialog(
        title: 'Exception',
        content: 'An error occurred: $e',
      );
    }
  }

  void _showDialog({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
