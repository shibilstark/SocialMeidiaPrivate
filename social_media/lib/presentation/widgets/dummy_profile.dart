import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DummyProfile extends StatelessWidget {
  const DummyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.sm,
      backgroundImage: AssetImage("assets/dummy/dummyDP.png"),
    );
  }
}
