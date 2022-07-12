import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  final double H;
  final double W;
  const Gap({
    Key? key,
    this.H = 0,
    this.W = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: H,
      width: W,
    );
  }
}
