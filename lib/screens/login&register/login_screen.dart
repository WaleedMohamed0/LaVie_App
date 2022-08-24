import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/cubits/posts_cubit/cubit.dart';
import 'package:life/network/cache_helper.dart';
import 'package:life/screens/free_seed/free_seed_screen.dart';
import 'package:life/screens/home_layout/home_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    var postsCubit = PostsCubit.get(context);
    var emailController = TextEditingController(),
        passwordController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          // to save user's accessToken
          CacheHelper.saveData(
              key: "token", value: appCubit.userModel!.accessToken);
          token = CacheHelper.getData(key: "token");
          appCubit.getProducts();
          appCubit.getBlogs();
          appCubit.getProfileData();
          postsCubit.getAllPosts();
          postsCubit.getMyPosts();
          if (appCubit.userModel!.address == null) {
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const FreeSeedScreen()));
          } else {
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeLayout()));
          }

          defaultToast(
              msg: appCubit.userModel!.message!,
              backgroundColor: defaultColor,
              textColor: Colors.white);
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
                  height: Adaptive.h(50),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Adaptive.w(10), Adaptive.h(2), Adaptive.w(10), 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        defaultText(
                            text: "Email",
                            textColor: HexColor('6F6F6F'),
                            fontWeight: FontWeight.w500),
                        defaultTextField(
                            txtinput: TextInputType.emailAddress,
                            controller: emailController),
                        defaultText(
                            text: "Password",
                            textColor: HexColor('6F6F6F'),
                            fontWeight: FontWeight.w500),
                        defaultTextField(
                            txtinput: TextInputType.visiblePassword,
                            controller: passwordController,
                            isPass: appCubit.isPass,
                            suffix: appCubit.isPass
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_outlined,
                            suffixPressed: () {
                              appCubit.changePasswordVisibility();
                            }),
                        SizedBox(
                          height: Adaptive.h(.4),
                        ),
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
                        SizedBox(
                          height: Adaptive.h(.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Divider(
                              color: HexColor('979797'),
                              thickness: 1,
                            )),
                            defaultText(
                                text: ' or continue with ',
                                textColor: HexColor('979797'),
                                fontSize: 12),
                            Expanded(
                                child: Divider(
                                    color: HexColor('979797'),
                                    thickness: 1)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage('assets/images/Google.png')),
                            SizedBox(
                              width: Adaptive.w(5),
                            ),
                            Image(
                                image:
                                    AssetImage('assets/images/Facebook.png')),
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
