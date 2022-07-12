import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.length})
      : super(key: key);
  final String hint;
  final TextEditingController controller;
  final int length;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: length,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      controller: controller,
      cursorColor: primaryBlue,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.sm),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withOpacity(0.5)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
            width: 1.sm,
          ),
          borderRadius: BorderRadius.circular(5.sm),
        ),
      ),
    );
  }
}
