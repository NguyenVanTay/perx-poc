import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeButton extends StatefulWidget {
  String QRsource;

  QRcodeButton({
    Key? key,
    required this.QRsource,
  }) : super(key: key);
  @override
  State<QRcodeButton> createState() => _QRcodeButtonState();
}

class _QRcodeButtonState extends State<QRcodeButton> {
  @override
  Widget build(BuildContext context) {
    String QRsource = widget.QRsource;

    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () => _dialogBuilder(context, QRsource),
      icon: const Icon(
        Icons.qr_code_2,
        size: 35,
        color: Colors.black,
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String QRsource) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(QRsource),
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }
}


// final Key renderKey = GlobalKey();

// class QRcodeButton extends StatefulWidget {
//   String code;

//   QRcodeButton({
//     Key? key,
//     required this.code,
//   }) : super(key: key);
//   @override
//   State<QRcodeButton> createState() => _QRcodeButtonState();
// }

// class _QRcodeButtonState extends State<QRcodeButton> {
//   @override
//   Widget build(BuildContext context) {
//     String code = widget.code;

//     return Container(
//       color: Colors.white,
//       child: IconButton(
//         padding: EdgeInsets.zero,
//         onPressed: () async => await _dialogBuilder(context, code),
//         icon: const Icon(
//           Icons.qr_code_2,
//           size: 45,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   Future<void> _dialogBuilder(BuildContext context, String code) async {
//     QrImageBuilder(code: code,key: renderKey);
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: Image.
        
//       ),
//     );
//   }

//   Future<Uint8List> createImageFromRenderKey({GlobalKey<State<StatefulWidget>>? renderKey}) async {
//     try {
//       final RenderRepaintBoundary boundary = renderKey?.currentContext?.findRenderObject()! as RenderRepaintBoundary;
//       final ui.Image image = await boundary.toImage(pixelRatio: 3);
//       final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

//       return byteData!.buffer.asUint8List();
//     } catch(_) {
//       rethrow;
//     }
//   }
// }


// class QrImageBuilder extends StatefulWidget {
//   String code;

//   QrImageBuilder({
//     Key? key,
//     required this.code,
//   }) : super(key: key);
//   @override
//   State<QrImageBuilder> createState() => _QrImageBuilderState();
// }

// class _QrImageBuilderState extends State<QrImageBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     String code = widget.code;

//     return QrImage(
//       data: code,
//       version: QrVersions.auto,
//       size: 200,
//       backgroundColor: Colors.white,
//     );
//   }
// }