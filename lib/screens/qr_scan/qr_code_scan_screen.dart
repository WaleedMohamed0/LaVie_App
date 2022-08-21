import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/screens/home_layout/home_layout.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  bool flashOn = false;
  BuildContext? context1;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  // @override
  // void reassemble() async{
  //   super.reassemble();
  //   if(Platform.isAndroid)
  //     {
  //       await controller!.pauseCamera();
  //     }
  //   else if(Platform.isIOS)
  //     {
  //
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    context1= context;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          buildQrView(context),
          Positioned(
            child: myIconButton(
                icon: flashOn ? Icons.flash_on :Icons.flash_off,
                onPressed: () {
                  toggleFlash();
                }),
            top: 10,
          )
        ],
      ),
    ));
  }

  Widget buildQrView(context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderColor: defaultColor,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      // To handle BUG [Camera Doesn't Open after first Load]
      controller.resumeCamera();

    controller.scannedDataStream.listen((barCode) {
        controller.stopCamera();
        controller.dispose();
        AppCubit.get(context1).getQrCodeData(recieptId: barCode);
       navigateTo(context, HomeLayout());
    });

  }

  void toggleFlash() {
    setState(() {
      flashOn =!flashOn;
      controller!.toggleFlash();
    });
  }
}
