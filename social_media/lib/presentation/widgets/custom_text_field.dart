import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/utility/functions/string_functions.dart';
import 'package:social_media/utility/functions/string_functions.dart';
import 'package:social_media/utility/functions/string_functions.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.type,
    required this.inputType,
    required this.prefixIcon,
  }) : super(key: key);

  bool isValid({required String value}) {
    if (type == "Email") {
      return value.isEmailvalid();
    } else if (type == "Name") {
      return value.isNameValid();
    } else {
      return value.isPasswordValid();
    }
  }

  final TextEditingController controller;

  final String type;
  final TextInputType inputType;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15.sm),
      validator: (value) {
        return value != null && isValid(value: value)
            ? null
            : "Enter A Valid ${type}";
      },
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: pureWhite,
        ),
        hintText: type,
        contentPadding:
            EdgeInsets.symmetric(vertical: 18.sm, horizontal: 10.sm),
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: pureWhite.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: pureWhite, width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: pureWhite, width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: pureWhite, width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: pureWhite, width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
      ),
    );
  }
}

class CustomTextFieldForPassword extends StatelessWidget {
  CustomTextFieldForPassword(
      {Key? key,
      required this.controller,
      required this.type,
      required this.inputType})
      : super(key: key);

  final TextEditingController controller;

  final String type;
  final TextInputType inputType;

  bool isValid({required String value}) {
    if (type == "Password") {
      return value.isPasswordValid();
    } else {
      return true;
    }
  }

  ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _valueNotifier,
        builder: (context, bool val, _) {
          return TextFormField(
            controller: controller,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 15.sm),
            validator: (value) {
              return value != null && isValid(value: value)
                  ? null
                  : "Enter A Valid  ${type}";
            },
            obscureText: _valueNotifier.value,
            keyboardType: inputType,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_valueNotifier.value) {
                    _valueNotifier.value = false;
                    _valueNotifier.notifyListeners();
                  } else {
                    _valueNotifier.value = true;
                    _valueNotifier.notifyListeners();
                  }
                },
                child: Icon(
                  !_valueNotifier.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: pureWhite,
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: pureWhite,
              ),
              hintText: type == "Login Password" ? "Password" : type,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18.sm, horizontal: 10.sm),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: pureWhite.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pureWhite, width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pureWhite, width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pureWhite, width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pureWhite, width: 1.sm),
                borderRadius: BorderRadius.circular(5.sm),
              ),
            ),
          );
        });
  }
}
