import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/cubits/buy_products/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../components/components.dart';
import '../../constants/constants.dart';
import '../../models/my_cart_products.dart';

class BuyProductsCubit extends Cubit<BuyProductsStates> {
  BuyProductsCubit() : super(BuyProductsInitialState());

  static BuyProductsCubit get(context) => BlocProvider.of(context);
  bool sameItem = false;
  // SQL Database

  late Database database;

  Future createDataBase() async {
    database = await openDatabase(
      'myCartItems.db', version: 1,
      onCreate: (database, version) async {
        await database
            .execute(
            'CREATE TABLE myCart (id INTEGER PRIMARY KEY , name text ,imageUrl text, itemQuantity INTEGER,productPrice INTEGER,totalProductPrice INTEGER,totalPrice INTEGER)')
            .then((value) {
          print("Table Created");
          emit(CreateDBTableSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(CreateDBTableErrorState());
        });
      },
      onOpen: (database) async {
        getMyCartItems(database);
      },
      // onUpgrade: (database , int oldVersion,int newVersion)
      // {
      //   if(oldVersion<newVersion)
      //     {
      //       database.execute("DROP TABLE myCart");
      //       // database.execute("ALTER TABLE myCart ADD COLUMN totalPrice INTEGER;");
      //     }
      // }
    );
  }

  Future insertToDataBase({
    required String name,
    required String imageUrl,
    required int itemQuantity,
    required int productPrice,
    required int totalProductPrice,
    required int totalPrice,
  }) async {
    await database
        .rawInsert(
        'INSERT INTO myCart (name ,imageUrl, itemQuantity ,totalProductPrice, productPrice , totalPrice) VALUES ("$name","$imageUrl" ,"$itemQuantity","$totalProductPrice","$productPrice","$totalPrice")')
        .then((value) {
      print('$value inserted Successfully');

      getMyCartItems(database);
      emit(ItemAddedInDBSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ItemAddedInDBErrorState());
    });
  }

  List<MyCartProducts> myCartProducts = [];
  int totalPrice = 0;

  Future getMyCartItems(Database database) async {
    myCartProducts = [];
    totalPrice = 0;
    await database.rawQuery('SELECT * FROM myCart').then((value) {
      for (var element in value) {
        totalPrice += element['totalProductPrice'] as int;
        myCartProducts.add(MyCartProducts(
          id: element['id'] as int,
          name: element['name'] as String,
          totalProductPrice: element['totalProductPrice'] as int,
          imageUrl: element['imageUrl'] as String,
          quantity: element['itemQuantity'] as int,
          productPrice: element['productPrice'] as int,
        ));
      }
      emit(GotDataFromDBSuccessState());
    }).catchError((error) {
      emit(GotDataFromDBErrorState());
      print(error.toString());
    });
  }

  Future deleteDataBase({required int id}) async {
    await database.rawDelete('DELETE FROM myCart where id = $id').then((value) {
      getMyCartItems(database);
      emit(ItemDeletedFromDBSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ItemDeletedFromDBErrorState());
    });
  }

  void updateDataBase({
    required int id,
    int? itemQuantity,
    int? productPrice,
    int? totalProductPrice,
    int? totalPrice,
  }) async {
    database.rawUpdate(
        'UPDATE myCart SET itemQuantity = ? , productPrice = ? , totalProductPrice = ? , totalPrice = ? where id = ?',
        [
          itemQuantity,
          productPrice,
          totalProductPrice,
          totalPrice,
          id
        ]).then((value) {
      getMyCartItems(database);
      emit(ItemUpdatedInDBSuccessState());
    });
  }




  void buyProduct(index) {
    for (var myCart in myCartProducts) {
      if (myCart.name == allProducts[index].name &&
          myCart.productPrice == allProducts[index].price) {
        sameItem = true;
        updateDataBase(
            id: myCart.id,
            itemQuantity: myCart.quantity + productsQuantity[index],
            totalProductPrice: allProducts[index].price *
                (myCart.quantity + productsQuantity[index]),
            totalPrice: totalPrice,
            productPrice: allProducts[index].price);
      }
    }
    if (!sameItem) {
      insertToDataBase(
        name: allProducts[index].name,
        imageUrl: allProducts[index].imageUrl == ""
            ? "assets/images/tree.png"
            : baseUrlForImage + allProducts[index].imageUrl,
        itemQuantity: productsQuantity[index],
        productPrice: allProducts[index].price,
        totalProductPrice: allProducts[index].price * productsQuantity[index],
        totalPrice:totalPrice ,
      );
    }
    sameItem = false;
    defaultToast(
        msg: "Item successfully added");
    emit(BuyProductSuccessState());
  }

  void removeProduct(index) {
    deleteDataBase(id: myCartProducts[index].id);
    emit(DeleteProductState());
  }

  void decrementCartProductQuantity(index) {
    if (myCartProducts[index].quantity > 1) {
      myCartProducts[index].totalProductPrice -=
          myCartProducts[index].productPrice;

      updateDataBase(
          id: myCartProducts[index].id,
          itemQuantity: --myCartProducts[index].quantity,
          productPrice: myCartProducts[index].productPrice,
          totalProductPrice: myCartProducts[index].totalProductPrice,
          totalPrice: myCartProducts[index].productPrice);
    }
    emit(DecrementProductCartQuantityState());
  }

  void incrementCartProductQuantity(index) {
    myCartProducts[index].totalProductPrice +=
        myCartProducts[index].productPrice;
    // totalPrice += myCartProducts[index].productPrice;
    updateDataBase(
        id: myCartProducts[index].id,
        itemQuantity: ++myCartProducts[index].quantity,
        productPrice: myCartProducts[index].productPrice,
        totalProductPrice: myCartProducts[index].totalProductPrice,
        totalPrice: myCartProducts[index].productPrice);
    emit(IncrementProductCartQuantityState());
  }

}
