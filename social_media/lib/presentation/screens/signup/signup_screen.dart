import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/auth/auth_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/app_constant_strings.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';

import 'package:social_media/core/themes/themes.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/util/functions/string_functions.dart';
import 'package:social_media/presentation/widgets/custom_text_field.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(child: SignUpBody()),
    );
  }
}

final dialogueKey = GlobalKey<NavigatorState>();

class SignUpBody extends StatelessWidget {
  SignUpBody({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: secondaryBlue,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primaryBlue, primary],
      )),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: constPadding,
            child: SingleChildScrollView(
                child: Column(
              children: [
                SignUpImagePartWidget(),
                SingUpFieldsWidget(formKey: _formKey),
                SignUpActionButtonWidget(formKey: _formKey),
                Gap(
                  H: 20.sm,
                ),
                AlreadyAmemberPart(),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class AlreadyAmemberPart extends StatelessWidget {
  const AlreadyAmemberPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushReplacementNamed("/login");
      },
      child: RichText(
          text: TextSpan(children: [
        // InlineSpan("Don't Have an Account?  ", style: smallTextureStyle),
        TextSpan(text: "Already memeber? ", style: smallTextureStyle),
        TextSpan(
            text: "Log in",
            style: smallTextureStyle.copyWith(fontWeight: FontWeight.bold))
      ])),
    );
  }
}

class SignUpActionButtonWidget extends StatelessWidget {
  const SignUpActionButtonWidget({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  bool _signUpFormValidate() {
    final validate = formKey.currentState!.validate();

    if (validate) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAccountCreateSuccess) {
          Navigator.of(context).pushReplacementNamed('/login');
          Fluttertoast.showToast(
              msg: "Account Created Successfully Please Login");
        } else if (state is AuthStateAccountCreateError) {
          Fluttertoast.showToast(msg: state.err.error);
        }
      },
      builder: (context, state) {
        return Builder(builder: (context) {
          return MaterialButton(
              color: pureWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sm)),
              onPressed: () async {
                if (_signUpFormValidate() && _checkBoxValue.value) {
                  final userId = const Uuid();
                  final currentDateTime = DateTime.now();
                  final UserModel model = UserModel(
                    name: TextFieldAuthenticationController.signupName.text
                        .trim()
                        .capitalizeFirst(),
                    email: TextFieldAuthenticationController.signupEmail.text
                        .trim(),
                    isAgreed: true,
                    isPrivate: false,
                    isBlocked: false,
                    creationDate: currentDateTime,
                    userId: userId.v4(),
                    discription: profileDiscriptionAuto,
                    followers: [],
                    following: [],
                    profileImage: null,
                    coverImage: null,
                  );
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<AuthBloc>().add(CreateAccount(
                        model: model,
                        password: TextFieldAuthenticationController
                            .signupPassword.text
                            .trim()));
                  });
                }
              },
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.sm, horizontal: 50.sm),
                  child: state is AuthStateLoading &&
                          state is! AuthStateAccountCreateError &&
                          state is! AuthStateAccountCreateSuccess
                      ? SizedBox(
                          height: 20.sm,
                          width: 20.sm,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: primary,
                          )),
                        )
                      : Text("Create Account", style: roundedButtonStyle)));
        });
      },
    );
  }
}

class SingUpFieldsWidget extends StatelessWidget {
  const SingUpFieldsWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 350.sm),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: TextFieldAuthenticationController.signupName,
              type: "Name",
              inputType: TextInputType.name,
              prefixIcon: Icons.badge,
            ),
            Gap(
              H: 15.sm,
            ),
            CustomTextField(
                controller: TextFieldAuthenticationController.signupEmail,
                type: "Email",
                inputType: TextInputType.emailAddress,
                prefixIcon: Icons.email),
            Gap(
              H: 15.sm,
            ),
            CustomTextFieldForPassword(
              controller: TextFieldAuthenticationController.signupPassword,

              type: "Password",
              inputType: TextInputType.name,
              //  prefixIcon: Icons.badge,
            ),
            Gap(
              H: 15.sm,
            ),
            const ConformPasswordTextField(),
            Gap(
              H: 20.sm,
            ),
            const CheckBoxWidget(),
            Gap(
              H: 40.sm,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpImagePartWidget extends StatelessWidget {
  const SignUpImagePartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/svg/account.svg",
          width: 350.sm,
        ),
        Gap(
          H: 60.sm,
        ),
      ],
    );
  }
}

ValueNotifier<bool> _valueNotifier = ValueNotifier(true);

class ConformPasswordTextField extends StatelessWidget {
  const ConformPasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _valueNotifier,
        builder: (context, bool val, _) {
          return TextFormField(
            controller: TextFieldAuthenticationController.signupConformPassword,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 15.sm),
            validator: (value) {
              return TextFieldAuthenticationController
                              .signupConformPassword.text
                              .trim() !=
                          TextFieldAuthenticationController
                              .signupConformPassword.text
                              .trim() ||
                      TextFieldAuthenticationController
                          .signupConformPassword.text
                          .trim()
                          .isEmpty
                  ? "Password must be same"
                  : null;
            },
            obscureText: _valueNotifier.value,
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
              prefixIcon: const Icon(
                Icons.lock,
                color: pureWhite,
              ),
              hintText: "Conform Password",
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

ValueNotifier<bool> _checkBoxValue = ValueNotifier(false);

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _checkBoxValue,
        builder: (context, bool value, _) {
          return Row(
            children: [
              SizedBox(
                height: 20.sm,
                width: 20.sm,
                child: Checkbox(
                  fillColor:
                      MaterialStateProperty.all(pureWhite.withOpacity(0.8)),
                  checkColor: primaryBlue,
                  value: _checkBoxValue.value,
                  activeColor: primaryBlue,
                  onChanged: (value) {
                    _checkBoxValue.value = value!;
                    _checkBoxValue.notifyListeners();
                  },
                ),
              ),
              Gap(W: 10.sm),
              Text(
                "I Accept all Terms and Conditions & Privacy Policy",
                style: _checkBoxValue.value
                    ? smallTextureStyle
                    : smallTextureStyle.copyWith(
                        color: pureWhite.withOpacity(0.7)),
              )
            ],
          );
        });
  }
}
