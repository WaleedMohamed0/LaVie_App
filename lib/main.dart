import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/buy_products/cubit.dart';
import 'package:life/cubits/posts_cubit/cubit.dart';
import 'package:life/network/cache_helper.dart';
import 'package:life/network/dio.dart';
import 'package:life/screens/home_layout/home_layout.dart';

import 'package:life/screens/start_up/start_up_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubits/bottom_nav/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();

  token = CacheHelper.getData(key: "token");
  getQuizNotification();
  print(token);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AppCubit()
        ..getProducts()
        ..getBlogs()
        ..getProfileData(),
    ),
    BlocProvider(
      create: (context) => BuyProductsCubit()..createDataBase(),
    ),
    BlocProvider(
      create: (context) => BottomNavCubit(),
    ),
    BlocProvider(
      create: (context) => PostsCubit()
        ..getAllPosts()
        ..getMyPosts(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? screen;
    if (token == null) {
      screen = const StartUpScreen();
    } else {
      screen = const HomeLayout();
    }
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white, elevation: 0)),
          debugShowCheckedModeBanner: false,
          // home: screen,
          home: (AnimatedSplashScreen(
              splash: splash(),
              centered: true,
              splashIconSize: 900,
              nextScreen: screen!)),
        );
      },
    );
  }
}

Widget splash() {
  return const Center(
    child: Image(
      image: AssetImage('assets/images/LaVie.png'),
    ),
  );
  //Image.asset();
}
