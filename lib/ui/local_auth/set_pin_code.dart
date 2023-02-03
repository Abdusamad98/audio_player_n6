import 'package:audio_player_n6/data/storage.dart';
import 'package:audio_player_n6/main.dart';
import 'package:audio_player_n6/ui/audio/audio_screen.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/local_auth_pinput.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/pinput_keyboard.dart';
import 'package:flutter/material.dart';

class SetPinCode extends StatefulWidget {
  const SetPinCode({Key? key}) : super(key: key);

  @override
  State<SetPinCode> createState() => _SetPinCodeState();
}

class _SetPinCodeState extends State<SetPinCode> {
  final _pinPutController = TextEditingController();
  int confirmStep = 1;
  String passwordTitle = "Parol kiriting";
  String firstAttemptPin = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Set pin code screen"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.logo_dev,
            size: 100,
            color: Colors.yellow,
          ),
          const SizedBox(height: 24),
          Text(
            passwordTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          LocalAuthPinPut(
            pinPutController: _pinPutController,
            onCompleted: (String pin) {
              if (pin.length == 4) validatePin(pin);
            },
          ),
          const SizedBox(height: 24),
          PinPutKeyboard(
            width: width,
            height: height,
            numbersTap: (e) {
              _pinPutController.text = '${_pinPutController.text}$e';
            },
            zeroTap: () {
              _pinPutController.text = '${_pinPutController.text}0';
            },
            clearTap: () {
              if (_pinPutController.text.isNotEmpty) {
                _pinPutController.text = _pinPutController.text
                    .substring(0, _pinPutController.text.length - 1);
              }
            },
            bottomWidget: SizedBox(),
          ),
        ],
      ),
    );
  }

  void validatePin(String pin) async {
    if (confirmStep == 1) {
      firstAttemptPin = pin;
      confirmStep = 2;
      _pinPutController.clear();
      passwordTitle = "Tasdiqlang";
      setState(() {});
    } else if (confirmStep == 2) {
      if (pin == firstAttemptPin) {
        await StorageRepository.putString("local_pin", pin);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AudioScreen();
        }));
        getMyToast(message: "Success");
      } else {
        firstAttemptPin = "";
        _pinPutController.clear();
        passwordTitle = "Passwordni o'rnating!";
        confirmStep = 1;
        setState(() {});
      }
    }
  }
}
