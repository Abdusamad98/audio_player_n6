import 'package:audio_player_n6/ui/audio/audio_screen.dart';
import 'package:audio_player_n6/ui/local_auth/bloc/local_auth_bloc.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/local_auth_pinput.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/pinput_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pin code screen"),
      ),
      body: BlocListener<LocalAuthBloc, LocalAuthState>(
        listener: (context, state) {
          if (state.validPassword) {
            print("STATE KELDI ${state.validPassword}");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return AudioScreen();
            }));
          } else {
            setState(() {
              _pinPutController.clear();
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.logo_dev,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            const Text(
              "Password kriting",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            LocalAuthPinPut(
              pinPutController: _pinPutController,
              onCompleted: (String pin) {
                if (pin.length == 4) {
                  context
                      .read<LocalAuthBloc>()
                      .add(ValidateCurrentPin(pin: pin));
                }
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
              bottomWidget: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
