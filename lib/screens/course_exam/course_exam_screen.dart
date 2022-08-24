import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/quiz_model.dart';
import 'package:life/screens/home_layout/home_layout.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CourseExamScreen extends StatelessWidget {
  const CourseExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(title: 'Course Exam'),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    defaultText(
                        text: 'Question ',
                        fontSize: 25,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w500),
                    defaultText(
                      text: '${appCubit.questionIndex + 1}',
                      fontSize: 25,
                      textColor: defaultColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Adaptive.h(1)),
                      child: defaultText(
                          text: '/${quizList.length}',
                          textColor: Colors.grey[600]),
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(7),
                ),
                defaultText(
                    text: quizList[appCubit.questionIndex].question,
                    textColor: HexColor('3A3A3A'),
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return buildQuiz(quizList[appCubit.questionIndex],
                            index, appCubit, context);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: Adaptive.h(5),
                          ),
                      itemCount: quizList[appCubit.questionIndex]
                          .questionAnswers
                          .length),
                ),
                Row(
                  children: [
                    if (appCubit.questionIndex > 0)
                      Expanded(
                          child: defaultBtn(
                        txt: 'Back',
                        function: () {
                          appCubit.previousQuestion();
                        },
                        backgroundColor: Colors.transparent,
                        textColor: defaultColor,
                      )),
                    appCubit.questionIndex > 0
                        ? SizedBox(
                            width: Adaptive.w(3),
                          )
                        : SizedBox(),
                    Expanded(
                        child: defaultBtn(
                      txt: appCubit.questionIndex == 2 ? 'Finish' : 'Next',
                      function: () {
                        if (appCubit.questionIndex == 2 &&
                            quizList[appCubit.questionIndex].answered) {
                          timeForQuiz = false;
                          navigateAndFinish(context, HomeLayout());
                        } else {
                          if (quizList[appCubit.questionIndex].answered) {
                            appCubit.nextQuestion();
                          } else {
                            defaultToast(
                                msg: 'Please Choose an answer',
                                backgroundColor: Colors.red);
                          }
                        }
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildQuiz(QuizModel quizAnswer, index, AppCubit appCubit, context) {
    return InkWell(
      onTap: () {
        appCubit.answerSelected(index);
        if (quizAnswer.answerChosen == index) {
          defaultToast(msg: 'Correct Answer');
        } else {
          defaultToast(msg: 'Wrong Answer', backgroundColor: Colors.red);
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: defaultColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: defaultText(
                      text: quizAnswer.questionAnswers[index],
                      fontWeight: FontWeight.w500),
                ),
                quizAnswer.answerChosen == index
                    ? Image.asset('assets/images/SelectedAnswer.png')
                    : Image.asset('assets/images/UnSelectedAnswer.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
