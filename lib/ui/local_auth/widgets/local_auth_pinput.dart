import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class LocalAuthPinPut extends StatelessWidget {
  const LocalAuthPinPut({
    Key? key,
    required this.pinPutController,
    required this.onCompleted,
  }) : super(key: key);

  final TextEditingController pinPutController;
  final ValueChanged<String> onCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 20.0,
      height: 20.0,
      textStyle: const TextStyle(fontSize: 0.0, color: Colors.black),
      decoration: BoxDecoration(
        color:Colors.green,
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 20.0,
      child: Pinput(
        useNativeKeyboard: false,
        showCursor: false,
        length: 4,
        defaultPinTheme: defaultPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        onCompleted: onCompleted,
        controller: pinPutController,
        preFilledWidget: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1,color: Colors.white),
          color: Colors.black,
        )),
        followingPinTheme: defaultPinTheme,
        pinAnimationType: PinAnimationType.scale,
      ),
    );
  }
}
