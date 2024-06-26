import 'package:flutter/material.dart';

class BoxButtonWeb extends StatelessWidget {
  final Text text;
  final Color color;
  final void Function()? onTap;

  const BoxButtonWeb(
      {required this.text,
      required this.color,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 10.0,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 50.0,
          width: 500.0,
          child: Center(child: text),
        ),
      ),
    );
  }
}
