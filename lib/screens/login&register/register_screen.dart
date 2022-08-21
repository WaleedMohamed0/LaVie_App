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

import '../screen_size.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen(context);
    var cubit = AppCubit.get(context);
    var firstNameController = TextEditingController(),
        lastNameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        confirmPasswordController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          defaultToast(
              msg: cubit.userModel!.message!,
              backgroundColor: defaultColor,
              textColor: Colors.white);
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => StartUpScreen()));
        } else if (state is RegisterErrorState) {
          defaultToast(
              msg: "Please enter valid data",
              backgroundColor: Colors.red,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: SizedBox(
                    height: 500,
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
                              width: 15,
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
                          txtinput: TextInputType.text,
                          controller: passwordController,
                        ),
                        defaultText(text: 'Confirm password'),
                        defaultTextField(
                          txtinput: TextInputType.text,
                          controller: confirmPasswordController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Center(
                            child: defaultBtn(
                                txt: 'Register',
                                function: () {
                                  // appCubit.userLogin(
                                  //     email: emailController.text,
                                  //     password: passwordController.text);
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
                          height: 10,
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
                            Image(
                                image: AssetImage('assets/images/Google.png')),
                            SizedBox(
                              width: 30,
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
