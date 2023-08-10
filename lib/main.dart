import 'package:flutter/material.dart';
import 'package:frendify/Screens/email_verification_screen.dart';
import 'package:frendify/Screens/forgetpassword.dart';
import 'package:frendify/Screens/home_screen.dart';
import 'package:frendify/Screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/feed_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: 'login_screen',
            routes: {
              'login_screen': (context) => const LoginScreen(),
              'feed_screen': (context) => const FeedScreen(),
              'home_screen': (context) => const HomeScreen(),
              'email_verification_screen': (context) =>
                  const EmailVerificationScreen(),
              'forget_password_screen': (context) => const ForgetPassword(),
            },
          );
        });
  }
}
