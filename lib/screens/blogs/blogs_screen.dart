import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/blogs_model.dart';
import 'package:life/screens/blogs/blog_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:defaultAppBar(title: "Blogs",),
          body: ConditionalBuilder(
            condition: appCubit.gotBlogs,
            builder: (context) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildBlogsItem(
                        appCubit.allBlogs[index], appCubit, context);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: Adaptive.h(1),
                      ),
                  itemCount: appCubit.allBlogs.length);
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildBlogsItem(BlogsData blog, AppCubit appCubit, context) {
    return Column(
      children: [
        SizedBox(
          height: Adaptive.h(3),
        ),
        InkWell(
          onTap: () {
            navigateTo(
                context,
                BlogDetailsScreen(
                  blogClicked: blog,
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 7,
                child: Container(
                  margin:  EdgeInsets.symmetric(vertical: Adaptive.h(1.2)),
                  padding: EdgeInsets.only(left: Adaptive.w(1)),
                  width: Adaptive.w(86),
                  height: Adaptive.h(17),
                  child: Row(
                    children: [
                      blog.imageUrl == ""
                          ? Image(
                              image: AssetImage('assets/images/blogTree.png'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: NetworkImage(
                                    baseUrlForImage + blog.imageUrl),
                                width: Adaptive.w(35),
                                fit: BoxFit.cover,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(left: Adaptive.w(3)),
                        width:  Adaptive.w(44) ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            defaultText(
                                text: blog.name,
                                textOverflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            defaultText(
                              text: blog.description,
                              textColor: Colors.grey,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
