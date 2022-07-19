import 'package:flutter/material.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/screens/login/login_screen.dart';
import 'package:social_media/presentation/screens/profile/profile_screen.dart';
import 'package:social_media/presentation/screens/signup/signup_screen.dart';
import 'package:social_media/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routSettings) {
    switch (routSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/profile":
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      // case "/uploadpost":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => UploadPostScreen(
      //             postTypeModel: args.args['postTypeModel'],
      //           ));
      // case "/editprofile":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => EditProfileScreen(
      //             userModel: args.args['userModel'],
      //           ));
      // case "/onlinevideoplayer":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => SeePostVideoOnline(
      //             video: args.args['path'],
      //           ));
      // case "/offlinevideoplayer":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => SeePostVideoOffline(
      //             video: args.args['path'],
      //           ));
      // case "/seeimageonline":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => SeePostImageNetwork(
      //             image: args.args['path'],
      //           ));
      // case "/seeimageoffline":
      //   final args = routSettings.arguments as ScreenArgs;
      //   return MaterialPageRoute(
      //       builder: (_) => SeePostImageOffline(
      //             image: args.args['path'],
      //           ));

      // // case "/profile":
      // //   return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        // return MaterialPageRoute(builder: (_) => SplashScreen());
        return null;
    }
  }
}

class ScreenArgs {
  final Map<String, dynamic> args;
  ScreenArgs({required this.args});
}
