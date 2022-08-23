import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/cubits/posts_cubit/cubit.dart';
import 'package:life/cubits/posts_cubit/states.dart';
import 'package:life/models/forum_category.dart';
import 'package:life/models/posts_model.dart';
import 'package:life/my_flutter_app_icons.dart';
import 'package:life/screens/posts/create_post_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postsCubit = PostsCubit.get(context);
    var appCubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultAppBar(
          title: 'Discussion Forums',
          fontWeight: FontWeight.w600,
          backgroundColor: Colors.grey[50]),
      body: BlocConsumer<PostsCubit, PostsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: postsCubit.gotAllPosts,
            builder: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:Adaptive.w(3) ,vertical: Adaptive.h(3)),
                  child: Column(
                    children: [
                      searchTextField(onSubmit: (String searchQuery) {
                        postsCubit.searchPosts(searchQuery);
                      }),
                      SizedBox(
                        height: Adaptive.h(2.5),
                      ),
                      Container(
                        height: Adaptive.h(5),
                        padding: EdgeInsets.symmetric(horizontal: Adaptive.h(1.2)),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildPostsCategory(
                                postsCubit.forumslist[index],
                                index,
                                postsCubit),
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  width: Adaptive.w(4),
                                ),
                            itemCount: postsCubit.forumslist.length),
                      ),
                       SizedBox(
                        height: Adaptive.h(3),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildPost(
                              appCubit,
                              postsCubit,
                              postsCubit.isSearch
                                  ? postsCubit.searchList[index]
                                  : postsCubit.allPosts
                                      ? postsCubit
                                          .allPostsModel!.postsData[index]
                                      : postsCubit
                                          .myPostsModel!.postsData[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: Adaptive.h(4),
                              ),
                          itemCount: postsCubit.isSearch
                              ? postsCubit.searchList.length
                              : postsCubit.allPosts
                                  ? postsCubit.allPostsModel!.postsData.length
                                  : postsCubit.myPostsModel!.postsData.length),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postsCubit.imagePath = null;
          navigateTo(context, const CreatePostScreen());
        },
        child: const Icon(
          Icons.add,
          size: 27,
        ),
      ),
    );
  }

  Widget buildPostsCategory(
      ForumsCategoryModel model, index, PostsCubit postsCubit) {
    return InkWell(
      onTap: () {
        postsCubit.filterPosts(index);
      },
      child: Container(
        width: Adaptive.w(28),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: model.fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: model.borderColor!, width: 2)),
        child: defaultText(
            text: model.text!,
            fontWeight: FontWeight.w500,
            // because hexColor cannot be given in constructor
            textColor: model.textColor == Colors.grey
                ? HexColor('979797')
                : model.textColor),
      ),
    );
  }

  Widget buildPost(AppCubit appCubit,PostsCubit postsCubit, PostsData post) {
    return Card(
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2),vertical: Adaptive.h(2)),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Ellipse.png',
                  width: Adaptive.w(14),
                ),
                 SizedBox(
                  width: Adaptive.w(3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                        text:
                            "${appCubit.userModel!.firstName!} ${appCubit.userModel!.lastName!}",
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                     SizedBox(
                      height: Adaptive.h(.4),
                    ),
                    defaultText(text: 'a month ago', textColor: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Adaptive.w(3)),
                child: defaultText(
                    text: post.title,
                    textColor: defaultColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.only(left: Adaptive.w(5)),
                child: defaultText(
                    text: post.description, textColor: HexColor('8F8D8D')),
              ),
            ],
          ),
           SizedBox(
            height: Adaptive.h(2),
          ),
          post.imageUrl == ""
              ? Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  baseUrlForImage + post.imageUrl,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5),vertical: Adaptive.h(2)),
            child: Row(
              children: [
                const Icon(
                  myIcons.like,
                ),
                 SizedBox(
                  width: Adaptive.w(2),
                ),
                InkWell(
                    onTap: ()
                    {
                      postsCubit.likePost(forumId: post.forumId);
                    },
                    child: defaultText(text: '0 Likes')),
                 SizedBox(
                  width: Adaptive.w(5.5),
                ),
                defaultText(text: '2 Replies'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
