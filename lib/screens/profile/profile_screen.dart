import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/profile_model.dart';
import 'package:life/network/cache_helper.dart';
import 'package:life/screens/posts/posts_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../course_exam/course_exam_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var appCubit = AppCubit.get(context);
    List<ProfileModel> profileModelList = [
      ProfileModel(
          text: 'Change Name',
          labelText1: 'Enter firstName',
          labelText2: 'Enter lastName',
          changeName: true,
          acceptFn: () {
            appCubit.userUpdate(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: appCubit.userModel!.email,
                address: "null");
            Navigator.pop(context);
          },
          controller1: firstNameController,
          controller2: lastNameController),
      ProfileModel(
          text: 'Change Email',
          changeName: false,
          acceptFn: () {
            appCubit.userUpdate(
                firstName: appCubit.userModel!.firstName,
                lastName: appCubit.userModel!.lastName,
                email:emailController.text,
                address: "null");
            Navigator.pop(context);
          },
          controller1: emailController,
          labelText1: 'Enter Email'),
      ProfileModel(
        text: 'Sign Out',
        acceptFn: () {
          CacheHelper.signOut(context);
        },
      ),
    ];
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
                                  vertical: Adaptive.h(3)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor('F3FEF1'),
                              ),
                              child: Row(
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
                                if (timeForQuiz)
                                  Container(
                                    margin: EdgeInsets.only(right: Adaptive.w(3)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Adaptive.w(3)),
                                            margin:
                                            EdgeInsets.only(right: Adaptive.w(1.5)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey[400],
                                            ),
                                            height: Adaptive.h(3.5),
                                            child: Center(
                                              child: defaultText(
                                                  text: 'Quiz Time', fontSize: 16),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            navigateTo(context, CourseExamScreen());
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.question_mark),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Adaptive.w(7)),
                                child: ListView.separated(
                                    padding:
                                        EdgeInsets.only(top: Adaptive.h(1.7)),
                                    itemBuilder: (context, index) =>
                                        buildProfileWidget(context,
                                            profileModelList[index], index),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: Adaptive.h(.1),
                                        ),
                                    itemCount: profileModelList.length),
                              ),
                            ),
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

  Widget buildProfileWidget(context, ProfileModel profileModel, index) {
    return InkWell(
      onTap: () {
        if (index == 0 || index == 1) {
          myDialog(
              text: profileModel.text,
              context: context,
              declineText: 'Cancel',
              acceptText: 'Save',
              controller1: profileModel.controller1,
              controller2: index == 0 ? profileModel.controller2 : null,
              labelTxt1: profileModel.labelText1,
              labelTxt2: profileModel.labelText2,
              changeName: profileModel.changeName!,
              declineFn: () {
                Navigator.pop(context);
              },
              acceptFn: profileModel.acceptFn);
        } else {
          profileModel.acceptFn();
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: Adaptive.h(1)),
          width: Adaptive.w(84),
          height: Adaptive.h(9.3),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                Adaptive.w(4), Adaptive.h(1), Adaptive.w(3), Adaptive.h(1)),
            child: Row(
              children: [
                profileModel.image!,
                SizedBox(
                  width: Adaptive.w(4.7),
                ),
                defaultText(
                    text: profileModel.text,
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
    );
  }
}
