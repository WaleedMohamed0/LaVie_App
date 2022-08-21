import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/screens/login&register/login_screen.dart';
import 'package:life/screens/login&register/register_screen.dart';
import 'package:life/screens/screen_size.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(Screen.getScreenWidth);
    // Screen(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 300,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 200,
                centerTitle: true,
                title: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage('assets/images/LaVie.png'),
                  ),
                ),
                actions: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/treeTop.png',
                        ),
                        width: 120,
                      ),
                    ],
                  ),
                ],
                bottom: TabBar(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 3.0),
                        insets:
                            EdgeInsets.symmetric(horizontal: 10)),
                    unselectedLabelColor: Colors.grey[600],
                    labelColor: Colors.green,
                    indicatorColor: Color.fromRGBO(26, 188, 0, 1),
                    tabs: [
                      Container(
                        width: 70,
                        child: Tab(text: "Sign up"),
                      ),
                      Container(width: 70, child: Tab(text: "Login")),
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MaterialApp(
                    home: RegisterScreen(),
                    debugShowCheckedModeBanner: false,
                  ),
                  MaterialApp(
                    home: LoginScreen(),
                    debugShowCheckedModeBanner: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
