import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/auth/auth_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/core/themes/themes.dart';
import 'package:social_media/presentation/widgets/custom_text_field.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(child: LoginBody()),
    );
  }
}

final dialogueKey = GlobalKey<NavigatorState>();

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: secondaryBlue,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primary, primaryBlue],
      )),
      child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          height: double.infinity,
          child: Padding(
            padding: constPadding,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LoginImageAndFIeldWIdget(formKey: _formKey),
                    LoginActionButtonWidget(
                      formKey: _formKey,
                    ),
                    Gap(
                      H: 20.sm,
                    ),
                    const NotAmemberWidget(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class LoginActionButtonWidget extends StatelessWidget {
  const LoginActionButtonWidget({
    Key? key,
    required GlobalKey<FormState> this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  bool _loginFormValidate() {
    final validate = formKey.currentState!.validate();

    if (validate) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLogginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Fluttertoast.showToast(msg: "Logging in");
              context.read<ProfileBloc>().add(GetCurrentUser());
              Navigator.of(context).pushReplacementNamed("/home");
            });
          } else if (state is AuthStateLogginError) {
            Fluttertoast.showToast(msg: state.error.error);
          }
        },
        builder: (context, state) {
          return Builder(builder: (context) {
            return MaterialButton(
                color: pureWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sm)),
                onPressed: () async {
                  if (_loginFormValidate()) {
                    final email = TextFieldAuthenticationController
                        .loginEmail.text
                        .trim();
                    final password = TextFieldAuthenticationController
                        .loginPassword.text
                        .trim();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context
                          .read<AuthBloc>()
                          .add(LoggedIn(email: email, password: password));
                    });
                  }
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.sm, horizontal: 50.sm),
                    child: state is AuthStateLoading &&
                            state is! AuthStateLogginSuccess &&
                            state is! AuthStateLogginError
                        ? SizedBox(
                            height: 20.sm,
                            width: 20.sm,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: primary,
                            )),
                          )
                        : Text("Log In", style: roundedButtonStyle)));
          });
        },
      ),
    );
  }
}

class NotAmemberWidget extends StatelessWidget {
  const NotAmemberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushReplacementNamed("/signup");
      },
      child: RichText(
          text: TextSpan(children: [
        // InlineSpan("Don't Have an Account?  ", style: smallTextureStyle),
        TextSpan(text: "Not a member? ", style: smallTextureStyle),
        TextSpan(
            text: "Sign up",
            style: smallTextureStyle.copyWith(fontWeight: FontWeight.bold))
      ])),
    );
  }
}

class LoginImageAndFIeldWIdget extends StatelessWidget {
  const LoginImageAndFIeldWIdget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Application Name",
          style: titleLarge,
        ),
        Gap(
          H: 40.sm,
        ),
        SvgPicture.asset(
          "assets/svg/account access.svg",
          width: 250.sm,
        ),
        Gap(
          H: 60.sm,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 350.sm),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: TextFieldAuthenticationController.loginEmail,
                  type: "Email",
                  inputType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                ),
                Gap(
                  H: 20.sm,
                ),
                CustomTextFieldForPassword(
                    controller: TextFieldAuthenticationController.loginPassword,
                    type: "Login Password",
                    inputType: TextInputType.visiblePassword),
                Gap(
                  H: 40.sm,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
