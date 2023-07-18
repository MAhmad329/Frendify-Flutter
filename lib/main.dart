import 'package:flutter/material.dart';
import 'package:frendify/screens/home_screen.dart';
import 'package:frendify/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/screens/feed_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
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
            initialRoute: 'login_screen',
            routes: {
              'login_screen': (context) => const Login(),
              'feed_screen': (context) => const FeedScreen(),
              'home_screen': (context) => const HomeScreen(),
            },
          );
        });
  }
}
