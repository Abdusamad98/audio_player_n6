import 'package:audio_player_n6/ui/local_auth/widgets/keyboard_button.dart';
import 'package:flutter/material.dart';

class PinPutKeyboard extends StatelessWidget {
  const PinPutKeyboard({
    Key? key,
    required this.width,
    required this.height,
    required this.numbersTap,
    required this.zeroTap,
    required this.clearTap,
    required this.bottomWidget,
  }) : super(key: key);
  final double width;
  final double height;
  final ValueChanged<String> numbersTap;
  final VoidCallback zeroTap;
  final VoidCallback clearTap;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width * 0.9,
      child: GridView.count(
        crossAxisCount: 3,
        //childAspectRatio: 1.6,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...[1, 2, 3, 4, 5, 6, 7, 8, 9].map((e) {
            return KeyboardButtonWidget(
              title: '$e',
              onTap: () => numbersTap.call('$e'),
            );
          }),
          bottomWidget,
          KeyboardButtonWidget(
            title: '0',
            onTap: zeroTap,
          ),
          IconButton(
            onPressed: clearTap,
            icon: const Icon(
              Icons.backspace,
              color: Colors.red,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
