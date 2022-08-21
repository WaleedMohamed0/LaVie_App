import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/network/cache_helper.dart';
import 'package:life/screens/free_seed/free_seed_screen.dart';
import 'package:life/screens/home_layout/home_layout.dart';

import '../../constants/constants.dart';
import '../screen_size.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen(context);
    // Screen(context);
    var appCubit = AppCubit.get(context);
    var emailController = TextEditingController(),
        passwordController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          // to save user's accessToken
          CacheHelper.saveData(
              key: "token", value: appCubit.userModel!.accessToken);
          token = CacheHelper.getData(key: "token");
          defaultToast(
              msg: appCubit.userModel!.message!,
              backgroundColor: defaultColor,
              textColor: Colors.white);
          if (!appCubit.newUser) {
            // to remove tab Bar from viewing
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeLayout()));
          } else {
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const FreeSeedScreen()));
            appCubit.newUser = false;
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // width: Screen.getScreenWidth/1.2,
                  height:450,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, 20, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        defaultText(text: "Email", textColor: HexColor('6F6F6F')),

                        defaultTextField(
                            txtinput: TextInputType.emailAddress,
                            controller: emailController),
                        defaultText(
                            text: "Password", textColor: HexColor('6F6F6F')),

                        defaultTextField(
                            txtinput: TextInputType.visiblePassword,
                            controller: passwordController,
                            isPass: appCubit.isPass,
                            suffix: appCubit.isPass
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_outlined,
                            SuffixPressed: () {
                              appCubit.changePasswordVisibility();
                            }),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Center(
                            child: defaultBtn(
                                txt: 'Login',
                                function: () {
                                  appCubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                },
                                borderRadius: 7),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                child: Divider(
                              height: 10,
                              color: Colors.black,
                            )),
                            defaultText(
                                text: ' or continue with ',
                                textColor: Colors.grey,
                                fontSize: 12),
                            const Expanded(
                                child: Divider(
                              height: 10,
                              color: Colors.black,
                            )),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(image: AssetImage('assets/images/Google.png')),
                            SizedBox(
                              width: 30,
                            ),
                            Image(
                                image: AssetImage('assets/images/Facebook.png')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/treeBottom.png',
                    ),
                    // width: 100,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
