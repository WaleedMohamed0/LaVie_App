import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/products_model.dart';

import '../../models/products_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductsData? productClicked;
  int productIndex = 0;

  ProductDetailsScreen(
      {required this.productClicked, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    List<ProductDetailsModel> detailsList = [
      ProductDetailsModel(
          imageUrl: 'assets/images/sun.png',
          text: 'Sun light',
          detailsNumber: productClicked!.sunLight),
      ProductDetailsModel(
          imageUrl: 'assets/images/water.png',
          text: 'Water',
          detailsNumber: productClicked!.waterCapacity),
      ProductDetailsModel(
          imageUrl: 'assets/images/temperature.png',
          text: 'Temperature',
          detailsNumber: productClicked!.temperature)
    ];
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defaultAppBar(title: 'ProductDetails'),
          body: Center(
            child: Column(
              crossAxisAlignment: productClicked!.imageUrl == ""
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  width: productClicked!.imageUrl == "" ? 150 : double.infinity,
                  height: 290,
                  decoration: BoxDecoration(
                    image: productClicked!.imageUrl == ""
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/tree.png'),
                          )
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                baseUrlForImage + productClicked!.imageUrl),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              defaultText(
                                  text: productClicked!.name,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 8,
                              ),
                              defaultText(
                                  text: productClicked!.description,
                                  fontSize: 15,
                                  textColor: HexColor('7D7B7B')),
                            ],
                          ),
                          Spacer(),
                          defaultText(
                              text: '${productClicked!.price} EGP',
                              textColor: defaultColor,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 115,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildDetails(detailsList[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                            itemCount: detailsList.length),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultText(
                          text: 'Information',
                          textColor: HexColor('979797'),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: defaultText(
                          text:
                              'Native to southern Africa, snake plants are well adapted to conditions similar to those in southern regions of the United States.',
                          textColor: HexColor('979797'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          defaultText(
                              text: 'Qty :', fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            color: HexColor('F7F6F7'),
                            child: myIconButton(
                                padding: EdgeInsets.zero,
                                icon: Icons.remove,
                                size: 26,
                                color: Colors.grey,
                                onPressed: () {
                                  appCubit
                                      .decrementProductQuantity(productIndex);
                                }),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          defaultText(
                              text:
                                  '${appCubit.productsQuantity[productIndex]}',
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                          SizedBox(
                            width: 14,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            color: HexColor('F7F6F7'),
                            child: myIconButton(
                                padding: EdgeInsets.zero,
                                icon: Icons.add,
                                onPressed: () {
                                  appCubit
                                      .incrementProductQuantity(productIndex);
                                },
                                size: 26,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Center(
                          child: defaultBtn(
                              txt: 'Add To Cart'.toUpperCase(),
                              function: () {
                                appCubit.buyProduct(productIndex);
                              },
                              backgroundColor: HexColor('1ABC36'),
                              borderRadius: 15,
                              fontSize: 18))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetails(ProductDetailsModel detailsModel) => Container(
        width: 100,
        height: 115,
        decoration: BoxDecoration(
          color: HexColor('f4fcf2'),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultText(
                    text: '${detailsModel.detailsNumber}',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                SizedBox(
                  width: 4,
                ),
                Image.asset(detailsModel.imageUrl!),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            defaultText(text: detailsModel.text),
          ],
        ),
      );
}
