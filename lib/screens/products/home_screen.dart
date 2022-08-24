import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/cubits/buy_products/cubit.dart';
import 'package:life/cubits/posts_cubit/cubit.dart';
import 'package:life/models/home_category.dart';
import 'package:life/models/products_model.dart';
import 'package:life/screens/course_exam/course_exam_screen.dart';
import 'package:life/screens/posts/posts_screen.dart';
import 'package:life/screens/products/product_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'my_cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    var buyProductsCubit = BuyProductsCubit.get(context);
    var postsCubit = PostsCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: (state is SearchProductsSuccessState &&
                      appCubit.searchList.isEmpty)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Adaptive.w(5), vertical: Adaptive.h(5)),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child:
                                searchTextField(onSubmit: (String searchQuery) {
                              appCubit.searchProducts(searchQuery.toString());
                            }),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Image(
                                    image:
                                        AssetImage('assets/images/Frame.png')),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                defaultText(
                                    text:
                                        'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',
                                    fontSize: 18,
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ConditionalBuilder(
                      condition: appCubit.gotProducts,
                      builder: (context) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Adaptive.w(4),
                                vertical: Adaptive.h(4)),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                  AssetImage('assets/images/LaVie.png'),
                                  alignment: AlignmentDirectional.center,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: TextButton(
                                      onPressed: ()
                                      {
                                        navigateTo(context, PostsScreen());
                                      },
                                      child: defaultText(
                                          text: 'COMMUNITY',
                                          fontSize: 16,
                                          textColor: defaultColor)),
                                ),

                                // Search TextFormField
                                Row(
                                  children: [
                                    Expanded(
                                      child: searchTextField(
                                          onSubmit: (String searchQuery) {
                                        appCubit.searchProducts(
                                            searchQuery.toString());
                                      }),
                                    ),
                                    SizedBox(
                                      width: Adaptive.w(1),
                                    ),
                                    Container(
                                      width: Adaptive.w(13),
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
                                  height: Adaptive.h(2),
                                ),
                                // List View for Categories
                                SizedBox(
                                  height: Adaptive.h(4.2),
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          buildCategory(
                                              appCubit.categoryList[index],
                                              index,
                                              appCubit),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: Adaptive.w(6),
                                          ),
                                      itemCount: appCubit.categoryList.length),
                                ),
                                SizedBox(
                                  height: Adaptive.h(1),
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
                                        : allProducts.length,
                                    (index) => buildProductItem(
                                        buyProductsCubit,
                                        appCubit,
                                        appCubit.isSearch
                                            ? appCubit.searchList[index]
                                            : allProducts[index],
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
                    )),
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
        width: Adaptive.w(18),
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

  Widget buildProductItem(BuyProductsCubit buyProductsCubit, AppCubit appCubit,
      ProductsData product, index, context) {
    return InkWell(
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
                    width: Adaptive.w(42),
                    padding: EdgeInsets.only(
                        left: Adaptive.w(2),
                        bottom: Adaptive.h(1),
                        right: Adaptive.w(2)),
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
                        defaultText(
                            text: "${product.price} EGP",
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Center(
                            child: defaultBtn(
                                txt: 'Add To Cart',
                                function: () {
                                  buyProductsCubit.buyProduct(index);
                                },
                                backgroundColor: HexColor('1ABC36'),
                                borderRadius: 15,
                                width: Adaptive.w(33),
                                fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
              // Image and ( [-] 0 [+] )
              Positioned(
                top: -Adaptive.h(1),
                bottom:
                    product.imageUrl == "" ? Adaptive.h(21) : Adaptive.h(18),
                left: Adaptive.w(1.3),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    product.imageUrl == ""
                        ? Image(
                            image: AssetImage('assets/images/tree.png'),
                            // fit: BoxFit.fill,
                            height: Adaptive.h(18),
                          )
                        : Image(
                            image: NetworkImage(
                                baseUrlForImage + product.imageUrl),
                            width: Adaptive.h(10.6),
                            fit: BoxFit.cover,
                          ),
                    product.imageUrl == ""
                        ? SizedBox(
                            width: Adaptive.w(1.6),
                          )
                        : SizedBox(
                            width: Adaptive.w(1),
                          ),
                    Row(
                      children: [
                        Container(
                          width: Adaptive.w(6.3),
                          height: Adaptive.h(3),
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
                          width: Adaptive.w(1.5),
                        ),
                        defaultText(text: '${productsQuantity[index]}'),
                        SizedBox(
                          width: Adaptive.w(1.5),
                        ),
                        Container(
                          width: Adaptive.w(6.3),
                          height: Adaptive.h(3),
                          color: HexColor('F7F6F7'),
                          child: myIconButton(
                              padding: EdgeInsets.zero,
                              icon: Icons.add,
                              onPressed: () {
                                appCubit.incrementProductQuantity(index);
                              },
                              size: 26,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Image(image: AssetImage('assets/images/Frame.png')),
//       SizedBox(
//         height: Adaptive.h(3),
//       ),
//       defaultText(
//           text: 'Your cart is empty',
//           fontSize: 23,
//           fontWeight: FontWeight.bold),
//     ],
//   ),
// );
}
