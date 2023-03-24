import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeButton extends StatefulWidget {
  String qrData;
  QRcodeButton({
    Key? key,
    required this.qrData,
  }) : super(key: key);
  @override
  State<QRcodeButton> createState() => _QRcodeButtonState();
}

class _QRcodeButtonState extends State<QRcodeButton> {
  @override
  Widget build(BuildContext context) {
    String qrData = widget.qrData;
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      alignment: Alignment.center,
      onPressed: () => showDiaglogFunc(context, qrData),
      icon: const Icon(
        Icons.qr_code_2,
        size: 35,
        color: Colors.black,
      ),
    );
  }

  showDiaglogFunc(context, qrData) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: MediaQuery.of(context).size.height * 0.7,
              height: 340,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: QrImage(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 320.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
