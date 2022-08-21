import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/models/home_category.dart';
import 'package:life/models/products_model.dart';
import 'package:life/screens/products/product_details_screen.dart';
import 'my_cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is BuyProductSuccessState) {
          Fluttertoast.showToast(
              msg: "Item successfully added",
              backgroundColor: defaultColor,
              textColor: Colors.white);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
              condition: appCubit.gotProducts,
              builder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/LaVie.png'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Search TextFormField
                        Row(
                          children: [
                            Expanded(
                              child: searchTextField(
                                  onSubmit: (String searchQuery) {
                                appCubit.searchProducts(searchQuery.toString());
                              }),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                              width: 50,
                              height: 53,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  navigateTo(context, MyCartScreen());
                                },
                                icon: Icon(Icons.shopping_cart),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // List View for Categories
                        SizedBox(
                          height: 35,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildCategory(
                                  appCubit.categoryList[index],
                                  index,
                                  appCubit),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 30,
                                  ),
                              itemCount: appCubit.categoryList.length),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.8,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(
                            appCubit.isSearch
                                ? appCubit.searchList.length
                                : appCubit.allProducts.length,
                            (index) => buildProductItem(
                                appCubit,
                                appCubit.isSearch
                                    ? appCubit.searchList[index]
                                    : appCubit.allProducts[index],
                                index,
                                context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory(HomeCategoryModel model, index, cubit) {
    return InkWell(
      onTap: () {
        cubit.filterProducts(index);
      },
      child: Container(
        height: 35,
        width: 90,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: HexColor('F8F8F8'),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: model.borderColor!, width: 2)),
        child: defaultText(
            text: model.text!,
            // because hexColor cannot be given in constructor
            textColor: model.textColor == Colors.grey
                ? HexColor('979797')
                : model.textColor),
      ),
    );
  }

  Widget buildProductItem(
          AppCubit appCubit, ProductsData product, index, context) =>
      InkWell(
        onTap: () {
          navigateTo(
              context,
              ProductDetailsScreen(
                productClicked: product,
                productIndex: index,
              ));
        },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      width: 166,
                      padding: EdgeInsets.only(left: 10, bottom: 6, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultText(
                              text: product.name,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 5,
                          ),
                          defaultText(text: product.price.toString()),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: defaultBtn(
                                  txt: 'Add To Cart',
                                  function: () {
                                    appCubit.buyProduct(index);
                                  },
                                  backgroundColor: HexColor('1ABC36'),
                                  borderRadius: 15,
                                  width: 135,
                                  fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                ),
                // Image and ( [-] 0 [+] )
                Positioned(
                  top: -10,
                  bottom: product.imageUrl == "" ? 170 : 140,
                  left: 5,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      product.imageUrl == ""
                          ? Image(
                              image: AssetImage('assets/images/tree.png'),
                              // fit: BoxFit.fill,
                              height: 142,
                            )
                          : Image(
                              image: NetworkImage(
                                  baseUrlForImage + product.imageUrl),
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                      product.imageUrl == ""
                          ? SizedBox(
                              width: 7,
                            )
                          : SizedBox(),
                      Row(children: [Container(
                        width: 25,
                        height: 25,
                        color: HexColor('F7F6F7'),
                        child: myIconButton(
                            padding: EdgeInsets.zero,
                            icon: Icons.remove,
                            size: 26,
                            color: Colors.grey,
                            onPressed: () {
                              appCubit.decrementProductQuantity(index);
                            }),
                      ),
                        SizedBox(
                          width: 8,
                        ),
                        defaultText(text: '${appCubit.productsQuantity[index]}'),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          color: HexColor('F7F6F7'),
                          child: myIconButton(
                              padding: EdgeInsets.zero,
                              icon: Icons.add,
                              onPressed: () {
                                appCubit.incrementProductQuantity(index);
                              },
                              size: 26,
                              color: Colors.grey),
                        ),],)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
