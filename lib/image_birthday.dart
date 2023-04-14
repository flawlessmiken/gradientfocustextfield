import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BirthdayImage extends StatefulWidget {
  @override
  _BirthdayImageState createState() => _BirthdayImageState();
}

class _BirthdayImageState extends State<BirthdayImage> {
  GlobalKey _globalKey = GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      // Convert PNG to JPG
      img.Image? jpg = img.decodePng(pngBytes!);
      Uint8List jpgBytes = img.encodeJpg(jpg!);

      // Save the JPG file to local storage
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/birthday_image.jpg');
      await file.writeAsBytes(jpgBytes);

      // Share the JPG file
      Share.shareFiles([file.path]);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.green
                // image: DecorationImage(
                //   image: AssetImage('assets/flower_background.png'),
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          // Image.asset(
          //   'assets/birthday_image.png',
          //   height: 300,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          // ),
          Container(
            child: Material(
              color: Colors.green,
              child: InkWell(
                onTap: () async {
                  await _captureAndSharePng();
                },
                child: Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Happy Birthday!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
