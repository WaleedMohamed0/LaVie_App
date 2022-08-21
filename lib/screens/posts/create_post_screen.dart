import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/cubits/posts_cubit/cubit.dart';
import 'package:life/cubits/posts_cubit/states.dart';
import 'package:life/screens/posts/posts_screen.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postsCubit = PostsCubit.get(context);
    var titleController = TextEditingController(),
        descriptionController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title:
        defaultText(text: 'Create New Post', fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsCubit, PostsStates>(
        listener: (context, state)
        {
          if(state is AddPostSuccessState)
            {
              defaultToast(
                  msg: "Post successfully added",
                  backgroundColor: defaultColor,
                  textColor: Colors.white);
            }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      postsCubit.addPhoto();
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      padding: postsCubit.imagePath == null
                          ? const EdgeInsets.only(top: 28)
                          : null,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: defaultColor, width: 2)),
                      child: postsCubit.imagePath == null
                          ? Column(
                        children: [
                          const Icon(
                            Icons.add,
                            size: 34,
                            color: defaultColor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultText(
                              text: 'Add Photo', textColor: defaultColor),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          postsCubit.imagePath!,
                          alignment: AlignmentDirectional.center,
                          fit: BoxFit.cover,
                          // height: 140,
                        ),
                      ),
                    ),
                  ),
                ),
                defaultText(
                    text: "Title",
                    textColor: HexColor('6F6F6F'),
                    fontWeight: FontWeight.bold),
                defaultTextField(
                  txtinput: TextInputType.text,
                  controller: titleController,
                ),
                defaultText(
                    text: "Description",
                    textColor: HexColor('6F6F6F'),
                    fontWeight: FontWeight.bold),
                defaultTextField(
                    txtinput: TextInputType.text,
                    maxLines: 6,
                    controller: descriptionController),
                Center(
                    child: defaultBtn(
                        txt: "Post",
                        function: () {
                          postsCubit.addPost(
                              imageBase64: postsCubit.imageBase64,
                              title: titleController.text,
                              description: descriptionController.text);
                          navigateTo(context, PostsScreen());
                        },
                        borderRadius: 10,
                        padding: EdgeInsets.all(5))),
              ],
            ),
          );
        },
      ),
    );
  }
}
