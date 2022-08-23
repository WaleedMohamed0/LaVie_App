import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/blogs_model.dart';
import 'package:life/models/free_seeds_model.dart';
import 'package:life/models/my_cart_products.dart';
import 'package:life/models/products_filters.dart';
import 'package:life/models/products_model.dart';
import 'package:life/models/seeds_model.dart';
import 'package:life/network/cache_helper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/constants.dart';
import '../../models/home_category.dart';
import '../../models/user_model.dart';
import '../../network/dio.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    emit(ChangePasswordVisibilityState());
  }

  UserModel? userModel;
  bool logged = false;

  void userRegister({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? password,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(endPoint: 'auth/signup', data: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(RegisterSuccessState());
      // logged = true;
    }).catchError((error) {
      if (error is DioError) {
        defaultToast(
            msg: "${error.response!.data['message']}",
            backgroundColor: Colors.red);
      }
      emit(RegisterErrorState());
    });
  }

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
        endPoint: 'auth/signin',
        data: {'email': email, 'password': password}).then((value) {
      userModel = UserModel.fromJson(value.data);

        emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        defaultToast(
            msg: "${error.response!.data['message']}",
            backgroundColor: Colors.red);
      }
      emit(LoginErrorState());
    });
  }

  bool newUser = true;

  // Future<bool> newUserCheck() async {
  //  await FirebaseFirestore.instance.collection('users').get().then((value) {
  //     for (var element in value.docs) {
  //       // Check if user is logged before or not
  //       if (element['userId'] == userModel!.id) {
  //         print("HEFERERERER");
  //        return false;
  //       }
  //     }
  //
  //
  //       print("NEWWWW");
  //       FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userModel!.id)
  //           .set({'userId': userModel!.id});
  //   });
  // return true;
  // }

  bool gotProfileData = false;

  void getProfileData() {
    emit(GetProfileDataLoadingState());
    if (token != null) {
      DioHelper.getData(endPoint: 'user/me', token: token).then((value) {
        userModel = UserModel.fromJson(value.data);
        // print(userModel!.notificationData[0].message);
        gotProfileData = true;
        emit(GetProfileDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetProfileDataErrorState());
      });
    }
  }

  bool userUpdated = false;

  void userUpdate({
    String? email,
    String? firstName,
    String? lastName,
  }) {
    emit(UpdateUserLoadingState());

    DioHelper.patchData(endPoint: 'user/me', token: token, data: {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      emit(UpdateUserErrorState());
      print(error.toString());
    });
  }

  List<ProductsData> searchList = [];
  bool isSearch = false;

  void searchProducts(String searchQuery) {
    isSearch = true;
    searchList = [];
    for (var product in allProducts) {
      if (product.name
          .toLowerCase()
          .contains(searchQuery.toString().toLowerCase())) {
        searchList.add(product);
      }
    }
    emit(SearchProductsSuccessState());
  }

  bool gotSeeds = false;
  ProductsModel? productsModel;

  void getProducts() {
    emit(GetProductsLoadingState());
    if (token != null) {
      DioHelper.getData(endPoint: 'products', token: token).then((value) {
        productsModel = ProductsModel.fromJson(value.data);
        // to select [All] In Categories
        categoryList[0].textColor = defaultColor;
        categoryList[0].borderColor = defaultColor;
        // to get all data [plants,seeds,tools]
        allProducts.addAll(productsModel!.plantsData);
        allProducts.addAll(productsModel!.seedsData);
        allProducts.addAll(productsModel!.toolsData);
        // To fill it with Ones
        productsQuantity = List.filled(allProducts.length, 1);

        gotProducts = true;
        emit(GetProductsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetProductsErrorState());
      });
    }
  }

  void filterProducts(index) {
    allProducts = [];
    isSearch = false;
    for (var category in categoryList) {
      category.textColor = HexColor('979797');
      category.borderColor = Colors.transparent;
    }
    if (index == 0) {
      allProducts.addAll(productsModel!.plantsData);
      allProducts.addAll(productsModel!.seedsData);
      allProducts.addAll(productsModel!.toolsData);
    } else if (index == 1) {
      allProducts.addAll(productsModel!.plantsData);
    } else if (index == 2) {
      allProducts.addAll(productsModel!.seedsData);
    } else if (index == 3) {
      allProducts.addAll(productsModel!.toolsData);
    }
    productsQuantity = List.filled(allProducts.length, 1);

    categoryList[index].textColor = defaultColor;
    categoryList[index].borderColor = defaultColor;
    emit(CategoriesSuccessState());
  }

  BlogsModel? blogsModel;
  List<BlogsData> allBlogs = [];
  bool gotBlogs = false;

  void getBlogs() {
    emit(GetBlogsLoadingState());
    if (token != null) {
      DioHelper.getData(endPoint: 'products/blogs', token: token).then((value) {
        blogsModel = BlogsModel.fromJson(value.data);
        // to get all data [plants,seeds,tools]
        allBlogs.addAll(blogsModel!.plantsData);
        allBlogs.addAll(blogsModel!.seedsData);
        allBlogs.addAll(blogsModel!.toolsData);
        gotBlogs = true;
        emit(GetBlogsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetBlogsErrorState());
      });
    }
  }

  // void getSeeds() {
  //   emit(GetSeedsLoadingState());
  //   DioHelper.getData(endPoint: 'seeds', token: userModel!.accessToken)
  //       .then((value) {
  //     seedsModel = SeedsModel.fromJson(value.data);
  //     gotSeeds = true;
  //     emit(GetSeedsSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetSeedsErrorState());
  //   });
  // }

  bool gotProducts = false;

  // void getProductsFilters() {
  //   emit(GetProductsFiltersLoadingState());
  //   DioHelper.getData(
  //           endPoint: 'products/filters', token: userModel!.accessToken)
  //       .then((value) {
  //     productsFilters = ProductsFilters.fromJson(value.data);
  //     allProducts.addAll(productsFilters!.plantsNames);
  //     allProducts.addAll(productsFilters!.seedsNames);
  //     allProducts.addAll(productsFilters!.toolsNames);
  //     // To select (All) in Filters
  //     categoryList[0].textColor = defaultColor;
  //     categoryList[0].borderColor = defaultColor;
  //     // To fill it with Ones
  //     productsQuantity = List.filled(allProducts.length, 1);
  //     gotProducts = true;
  //     emit(GetProductsFiltersSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetProductsFiltersErrorState());
  //   });
  // }

  List<HomeCategoryModel> categoryList = [
    HomeCategoryModel(text: 'All'),
    HomeCategoryModel(text: 'Plants'),
    HomeCategoryModel(text: 'Seeds'),
    HomeCategoryModel(text: 'Tools'),
  ];

  void decrementProductQuantity(index) {
    if (productsQuantity[index] > 1) {
      productsQuantity[index]--;
      emit(DecrementProductQuantityState());
    }
  }

  void incrementProductQuantity(index) {
    productsQuantity[index]++;
    emit(IncrementProductQuantityState());
  }

  void getQrCodeData({required Barcode recieptId}) {
    DioHelper.getData(endPoint: 'user/reciepts/$recieptId').then((value) {
      print(value.data);
    }).catchError((error) {
      print(error.toString());
    });
  }

  FreeSeedsModel? freeSeedsModel;

  void claimFreeSeeds({required String address}) {
    DioHelper.postData(
        endPoint: 'user/me/claimFreeSeeds',
        token: token,
        data: {'address': address}).then((value) {
      freeSeedsModel = FreeSeedsModel.fromJson(value.data);
      print(freeSeedsModel!.message);
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<String> quizQuestions = [
    'What is the user experience?',
    'Which of the following is not a programming language?',
    'Python is _____ programming language.'
  ];

  List<String> quizAnswers = [
    'The user experience is how the developer feels about a user.',
    'The user experience is how the user feels about interacting with or experiencing a product.'
        'The user experience is the attitude the UX designer has about a product.',
    'TypeScript'
        'Python',
    'Anaconda',
    'high-level'
        'mid-level'
        'low-level'
  ];
}
