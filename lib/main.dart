import 'package:audio_player_n6/data/storage.dart';
import 'package:audio_player_n6/ui/audio/audio_screen.dart';
import 'package:audio_player_n6/ui/local_auth/bloc/local_auth_bloc.dart';
import 'package:audio_player_n6/ui/local_auth/pin_code_screen.dart';
import 'package:audio_player_n6/ui/local_auth/set_pin_code.dart';
import 'package:audio_player_n6/ui/video/video_screen.dart';
import 'package:audio_player_n6/ui/video/videos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LocalAuthBloc()..add(CheckStatus()))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideosScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spalsh"),
      ),
      body: BlocListener<LocalAuthBloc, LocalAuthState>(
        child: const Center(
          child: Text("Splash"),
        ),
        listener: (context, state) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return state.status == LocalAuthStatus.localAuthUnset
                ? SetPinCode()
                : PinCodeScreen();
          }));
        },
      ),
    );
  }
}

getMyToast({required String message}) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      fontSize: 16.0,
    );
