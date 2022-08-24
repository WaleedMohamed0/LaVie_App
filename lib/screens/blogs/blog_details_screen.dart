import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/models/blogs_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';

class BlogDetailsScreen extends StatelessWidget {
  BlogsData? blogClicked;

  BlogDetailsScreen({super.key, required this.blogClicked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: Colors.black,
      //   centerTitle: true,
      //   title: defaultText(text: 'BlogDetails'),
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Adaptive.h(35),
              decoration: BoxDecoration(
                image: blogClicked!.imageUrl == ""
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/blogTreeSelected.png'),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            baseUrlForImage + blogClicked!.imageUrl),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:Adaptive.w(5) ,vertical: Adaptive.h(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  defaultText(
                      text: blogClicked!.name,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: Adaptive.h(1),
                  ),
                  defaultText(
                      text: blogClicked!.description,
                      fontSize: 15,
                      textColor: HexColor('7D7B7B')),
                  SizedBox(
                    height: Adaptive.h(3),
                  ),
                  defaultText(
                      text: '5 Simple Tips to treat plants',
                      fontSize: 21,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: Adaptive.h(2),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => defaultText(
                          text:
                              'leaf, in botany, any usually flattened green outgrowth from the stem of',
                          fontSize: 15,
                          textColor: HexColor('7D7B7B')),
                      separatorBuilder: (context, index) => SizedBox(
                            height: Adaptive.h(1.5),
                          ),
                      itemCount:5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
