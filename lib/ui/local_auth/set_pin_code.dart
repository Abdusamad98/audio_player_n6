import 'package:audio_player_n6/ui/audio/audio_screen.dart';
import 'package:audio_player_n6/ui/local_auth/bloc/local_auth_bloc.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/local_auth_pinput.dart';
import 'package:audio_player_n6/ui/local_auth/widgets/pinput_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetPinCode extends StatelessWidget {
  const SetPinCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pinPutController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Set pin code screen"),
      ),
      body: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        builder: (context, state) {
          return Column(
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
                state.confirmStep == 0
                    ? "Parol Kiriting"
                    : "Parolni tasdiqlang",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              LocalAuthPinPut(
                pinPutController: _pinPutController,
                onCompleted: (String pin) {
                  if (pin.length == 4) {
                    context.read<LocalAuthBloc>().add(
                          UpdateConfirmFields(
                            confirmStep: 1,
                            passwordText: pin,
                          ),
                        );
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
                bottomWidget: SizedBox(),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.validPassword) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AudioScreen();
                },
              ),
            );
          }
          if (state.confirmPassword.isEmpty || state.confirmStep == 1) {
            _pinPutController.clear();
          }
        },
      ),
    );
  }
}
