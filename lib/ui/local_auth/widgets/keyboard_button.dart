import 'package:flutter/material.dart';


class KeyboardButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const KeyboardButtonWidget(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Ink(

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: const Color(0xffE8E8E8),
                width: 1,
              ),
              // borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
