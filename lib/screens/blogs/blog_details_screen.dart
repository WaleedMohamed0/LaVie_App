import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/models/blogs_model.dart';

import '../../constants/constants.dart';

class BlogDetailsScreen extends StatelessWidget {
  BlogsData? blogClicked;

  BlogDetailsScreen({super.key, required this.blogClicked});

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: defaultText(text: 'BlogDetails'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 320,
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
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultText(
                    text: blogClicked!.name,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20,
                ),
                defaultText(
                    text: blogClicked!.description,
                    fontSize: 15,
                    textColor: HexColor('7D7B7B')),
                SizedBox(
                  height: 20,
                ),
                defaultText(
                    text: '4 Simple Tips to treat plants',
                    fontSize: 21,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => defaultText(
                        text:
                            'leaf, in botany, any usually flattened green outgrowth from the stem of',
                        fontSize: 15,
                        textColor: HexColor('7D7B7B')),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount:4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
