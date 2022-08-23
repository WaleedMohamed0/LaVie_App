import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/network/cache_helper.dart';
import 'package:life/screens/posts/posts_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {
          Fluttertoast.showToast(
              msg: appCubit.userModel!.message!,
              backgroundColor: defaultColor,
              textColor: Colors.white);
        } else if (state is UpdateUserErrorState) {
          Fluttertoast.showToast(
              msg: "Error in Updating Profile",
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          // appBar: defaultAppBar(foregroundColor: defaultColor, actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 6),
          //     child: defaultTextButton(
          //         text: 'posts',
          //         fn: () {
          //           navigateTo(context, PostsScreen());
          //         },
          //         fontWeight: FontWeight.w600,
          //         fontSize: 15),
          //   ),
          // ]),
          body: ConditionalBuilder(
            condition: appCubit.gotProfileData,
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        // Cover Photo
                        Container(
                          width: double.infinity,
                          height: Adaptive.h(40),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/coverPhoto.png'),
                            ),
                          ),
                        ),
                        // Black Cover
                        Container(
                          width: double.infinity,
                          height: Adaptive.h(40),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/blackCover.png'),
                            ),
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          height: Adaptive.h(29.5),
                          alignment: AlignmentDirectional.bottomCenter,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Ellipse.png'),
                            ),
                          ),
                          child: defaultText(
                              text:
                                  '${appCubit.userModel!.firstName} ${appCubit.userModel!.lastName!}',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: Adaptive.h(3),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: Adaptive.w(80),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Adaptive.w(2.7),
                                  vertical: Adaptive.h(2)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor('F3FEF1'),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/stars.png'),
                                  SizedBox(
                                    width: Adaptive.w(4),
                                  ),
                                  defaultText(
                                      text: 'You have 30 points',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3.5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: Adaptive.w(9)),
                                    child: defaultText(
                                        text: "Edit Profile",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(right: Adaptive.w(5)),
                                    child: defaultTextButton(
                                        text: 'Sign out',
                                        fn: () {
                                          CacheHelper.signOut(context);
                                        },
                                        textColor: defaultColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                myDialog(
                                    text: 'Change Name',
                                    context: context,
                                    declineText: 'Cancel',
                                    acceptText: 'Save',
                                    controller1: firstNameController,
                                    controller2: lastNameController,
                                    labelTxt1: 'Enter firstName',
                                    labelTxt2: 'Enter lastName',
                                    changeName: true,
                                    declineFn: () {
                                      Navigator.pop(context);
                                    },
                                    acceptFn: () {
                                      appCubit.userUpdate(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          email: appCubit.userModel!.email);
                                      Navigator.pop(context);
                                    });
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Adaptive.h(2)),
                                  width: Adaptive.w(84),
                                  height: Adaptive.h(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        Adaptive.w(4),
                                        Adaptive.h(1),
                                        Adaptive.w(3),
                                        Adaptive.h(1)),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: HexColor('1D592C'),
                                          child: Icon(
                                            Icons.security_update,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(4.7),
                                        ),
                                        defaultText(
                                            text: 'Change Name',
                                            textColor: Colors.black,
                                            fontSize: 16),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 28,
                                          color: HexColor('1D592C'),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                myDialog(
                                    text: 'Change Email',
                                    context: context,
                                    declineText: 'Cancel',
                                    acceptText: 'Save',
                                    controller1: emailController,
                                    labelTxt1: 'Enter Email',
                                    declineFn: () {
                                      Navigator.pop(context);
                                    },
                                    acceptFn: () {
                                      appCubit.userUpdate(
                                          email: emailController.text,
                                          firstName:
                                              appCubit.userModel!.firstName,
                                          lastName:
                                              appCubit.userModel!.lastName);
                                      Navigator.pop(context);
                                    });
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Adaptive.h(2)),
                                  width: Adaptive.w(84),
                                  height: Adaptive.h(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        Adaptive.w(4),
                                        Adaptive.h(1),
                                        Adaptive.w(3),
                                        Adaptive.h(1)),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: HexColor('1D592C'),
                                          child: Icon(
                                            Icons.security_update,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(4.7),
                                        ),
                                        defaultText(
                                            text: 'Change Email',
                                            textColor: Colors.black,
                                            fontSize: 16),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 28,
                                          color: HexColor('1D592C'),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: Adaptive.h(1),
                            ),
                            defaultTextButton(
                                text: 'posts',
                                fn: () {
                                  navigateTo(context, PostsScreen());
                                },
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
