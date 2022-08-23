import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';

import 'package:life/screens/start_up/start_up_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    var firstNameController = TextEditingController(),
        lastNameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        confirmPasswordController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          defaultToast(
              msg: appCubit.userModel!.message!,
              backgroundColor: defaultColor,
              textColor: Colors.white);
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => StartUpScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: SizedBox(
                    height: Adaptive.h(60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  defaultText(text: 'first Name'),
                                  defaultTextField(
                                    txtinput: TextInputType.text,
                                    controller: firstNameController,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(4),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  defaultText(text: 'last Name'),
                                  defaultTextField(
                                      txtinput: TextInputType.text,
                                      controller: lastNameController),
                                ],
                              ),
                            ),
                          ],
                        ),
                        defaultText(text: 'E-mail'),
                        defaultTextField(
                          txtinput: TextInputType.text,
                          controller: emailController,
                        ),
                        defaultText(text: 'Password'),
                        defaultTextField(
                            txtinput: TextInputType.visiblePassword,
                            controller: passwordController,

                        ),
                        defaultText(text: 'Confirm password'),
                        defaultTextField(
                            txtinput: TextInputType.visiblePassword,
                            controller: confirmPasswordController,

                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Center(
                            child: defaultBtn(
                                txt: 'Register',
                                function: () {
                                  if (passwordController.text ==
                                      confirmPasswordController.text) {
                                    appCubit.userRegister(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                  else {
                                    defaultToast(
                                        msg:
                                            'Please Enter Password same as Confirmation Password',
                                        backgroundColor: Colors.red);
                                  }
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
                          height: Adaptive.h(2),
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
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Image.asset(
                    'assets/images/treeBottom.png',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
