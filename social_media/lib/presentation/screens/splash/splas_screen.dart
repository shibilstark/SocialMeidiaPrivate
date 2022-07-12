import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/utility/util.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await UserDataStore.getUserData();

      if (data == null) {
        Navigator.of(context).pushReplacementNamed("/login");
      } else {
        Global.USER_DATA = data;
        Navigator.of(context).pushReplacementNamed("/home");
        // ignore: prefer_const_constructors
        context.read<CurrentUserBloc>().add(FetchCurrentuser());
      }
    });
    return const Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
