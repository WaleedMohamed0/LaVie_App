import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';

class CourseExamScreen extends StatelessWidget {
  const CourseExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        title: defaultText(text: 'Course Exam'),
        centerTitle: true,
      ),
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
                    fontWeight: FontWeight.w500),
                defaultText(
                  text: '1',
                  fontSize: 25,
                  textColor: defaultColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: defaultText(text: '/3', textColor: Colors.grey[600]),
                )
              ],
            ),
            SizedBox(
              height: 45,
            ),
            ListView.separated(
                itemBuilder: (context, index) => buildQuiz(),
                separatorBuilder: (context, index) => SizedBox(height: 15,),
                itemCount: 3),
          ],
        ),
      ),
    );
  }

  Widget buildQuiz() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: defaultText(
              text: 'What is the user experience?',
              textColor: HexColor('3A3A3A'),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 35,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: defaultColor, width: 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: defaultText(
                    text:
                        'The user experience is how the developer feels about a user.',
                    fontWeight: FontWeight.w500),
              ),
              Image.asset('assets/images/UnSelectedAnswer.png')
            ],
          ),
        ),
        Row(
          children: [
            defaultBtn(txt: 'Back', function: (){},borderRadius: 15),
            defaultBtn(txt: 'Next', function: (){},borderRadius: 15),
          ],
        )
      ],
    );
  }
}
