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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      searchTextField(onSubmit: (String searchQuery) {
                        postsCubit.searchPosts(searchQuery);
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildPostsCategory(
                                postsCubit.forumslist[index],
                                index,
                                postsCubit),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 30,
                                ),
                            itemCount: postsCubit.forumslist.length),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildPost(
                              appCubit,
                              postsCubit.isSearch
                                  ? postsCubit.searchList[index]
                                  : postsCubit.allPosts
                                      ? postsCubit
                                          .allPostsModel!.postsData[index]
                                      : postsCubit
                                          .myPostsModel!.postsData[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 30,
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
        height: 25,
        width: 130,
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

  Widget buildPost(AppCubit appCubit, PostsData post) {
    return Card(
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/Ellipse.png',
                  width: 65,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(
                        text:
                            "${appCubit.userModel!.firstName!} ${appCubit.userModel!.lastName!}",
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    const SizedBox(
                      height: 5,
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
                padding: const EdgeInsets.only(left: 10),
                child: defaultText(
                    text: post.title,
                    textColor: defaultColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: defaultText(
                    text: post.description, textColor: HexColor('8F8D8D')),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  myIcons.like,
                ),
                const SizedBox(
                  width: 7,
                ),
                defaultText(text: '0 Likes'),
                const SizedBox(
                  width: 30,
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
