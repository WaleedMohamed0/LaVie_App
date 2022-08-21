import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/cubits/bottom_nav/states.dart';
import 'package:life/screens/blogs/blogs_screen.dart';
import 'package:life/screens/notification/notification_screen.dart';
import 'package:life/screens/products/home_screen.dart';
import 'package:life/screens/profile/profile_screen.dart';
import 'package:life/screens/qr_scan/qr_code_scan_screen.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(context) => BlocProvider.of(context);

  int currentIndex = 4;

  void changeBottomNavScreen(int index) {
    currentIndex = index;
    emit(BottomNavSuccessState());
  }

  List<Widget> bottomNavScreens = [
    const BlogsScreen(),
    QRCodeScanner(),
    const NotificationScreen(),
    const ProfileScreen(),
    const HomeScreen(),
  ];
}
