import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life/cubits/posts_cubit/states.dart';
import 'package:life/models/posts_model.dart';

import '../../constants/constants.dart';
import '../../models/forum_category.dart';
import '../../network/dio.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  List<ForumsCategoryModel> forumslist = [
    ForumsCategoryModel(text: 'All Forums'),
    ForumsCategoryModel(text: 'My Forums'),
  ];
  PostsModel? myPostsModel;

  final ImagePicker imagePicker = ImagePicker();
  File? imagePath;
  Uint8List? imageInBytes;
  String imageBase64 = "";
  int indexOfDot = 0;
  String typeOfImage = "";

  void addPhoto() {
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      imagePath = Io.File(value!.path);
      imageInBytes = Io.File(value.path).readAsBytesSync();

      indexOfDot = value.name.indexOf('.');
      typeOfImage = value.name.substring(indexOfDot + 1);
      imageBase64 =
          "data:image/$typeOfImage;base64," '${base64.encode(imageInBytes!)}';
      print(imageBase64);
      print(typeOfImage);
      emit(GotImagePathSuccessState());
    });
  }

  void addPost(
      {required String imageBase64,
      required String title,
      required String description}) {
    emit(AddPostLoadingState());
    DioHelper.postData(endPoint: 'forums', token: token, data: {
      'title': title,
      'description': description,
      'imageBase64': imageBase64
    }).then((value) {
      getAllPosts();
      emit(AddPostSuccessState());
    }).catchError((error) {
      emit(AddPostErrorState());
      print(error.toString());
    });
  }

  bool gotMyPosts = false;

  void getMyPosts() {
    emit(GetPostsLoadingState());
    if (token != null) {
      DioHelper.getData(endPoint: 'forums/me', token: token).then((value) {
        myPostsModel = PostsModel.fromJson(value.data);
        // gotMyPosts = true;
        emit(GetPostsSuccessState());
      }).catchError((error) {
        emit(GetPostsErrorState());
        print(error.toString());
      });
    }
  }

  bool gotAllPosts = false;
  PostsModel? allPostsModel;

  void getAllPosts() {
    emit(GetPostsLoadingState());
    // to select All Forums at first
    forumslist[0].textColor = Colors.white;
    forumslist[0].borderColor = defaultColor;
    forumslist[0].fillColor = defaultColor;
    // to avoid errors in calling api without token
    if (token != null) {
      DioHelper.getData(endPoint: 'forums', token: token).then((value) {
        allPostsModel = PostsModel.fromJson(value.data);
        gotAllPosts = true;
        emit(GetPostsSuccessState());
      }).catchError((error) {
        emit(GetPostsErrorState());
        print(error.toString());
      });
    }
  }

  void likePost({required String forumId}) {
    print(forumId);
    DioHelper.postData(
        endPoint: 'forums/$forumId/like',
        data: {'forumId': forumId}).then((value) {
      print("LIKEDDDDDDDDDDDDDDDD");
    });
  }

  bool isSearch = false;
  List<PostsData> searchList = [];

  void searchPosts(String searchQuery) {
    isSearch = true;
    searchList = [];
    for (var product in myPostsModel!.postsData) {
      if (product.title
              .toLowerCase()
              .contains(searchQuery.toString().toLowerCase()) ||
          product.description
              .toLowerCase()
              .contains(searchQuery.toString().toLowerCase())) {
        searchList.add(product);
      }
      print(searchList[0].title);
    }
    emit(SearchPostsSuccessState());
  }

  bool allPosts = true;

  void filterPosts(index) {
    if (index == 0) {
      allPosts = true;
    }
    if (index == 1) {
      allPosts = false;
    }
    for (var forum in forumslist) {
      forum.textColor = HexColor('979797');
      forum.borderColor = Colors.grey[300];
      forum.fillColor = Colors.transparent;
    }
    forumslist[index].textColor = Colors.white;
    forumslist[index].borderColor = defaultColor;
    forumslist[index].fillColor = defaultColor;
    emit(ForumsSuccessState());
  }
}
