import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/cubits/bottom_nav/states.dart';
import 'package:life/my_flutter_app_icons.dart';

import '../../cubits/bottom_nav/cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen(context);
    var cubit = BottomNavCubit.get(context);
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: cubit.bottomNavScreens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(myIcons.home),
            onPressed: () {
              cubit.changeBottomNavScreen(4);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              borderColor: Colors.grey[300],
              activeColor: Colors.green,
              icons: [
                myIcons.posts,
                myIcons.qr_code,
                myIcons.notification,
                myIcons.profile,
              ],
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              activeIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavScreen(index);
              }),
        );
      },
    );
  }
}
