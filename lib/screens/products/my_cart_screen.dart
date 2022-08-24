import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/buy_products/cubit.dart';
import 'package:life/cubits/buy_products/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buyProductsCubit = BuyProductsCubit.get(context);
    return BlocConsumer<BuyProductsCubit, BuyProductsStates>(
      listener: (context, state) {
        if (state is DeleteProductState) {
          defaultToast(
            msg: 'Item Removed Successfully',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: defaultAppBar(
                title: "My Cart",
                elevation: 0,
                backgroundColor: Colors.transparent),
            body: buyProductsCubit.myCartProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/Frame.png')),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        defaultText(
                            text: 'Your cart is empty',
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                : FooterView(
                    flex: buyProductsCubit.myCartProducts.length > 1 ? 6 : 3,
                    footer: Footer(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Adaptive.w(8),
                              vertical: Adaptive.h(2.4)),
                          child: Row(
                            children: [
                              defaultText(
                                  text: "Total",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              Spacer(),
                              defaultText(
                                  text: "${buyProductsCubit.totalPrice} EGP",
                                  fontSize: 18,
                                  textColor: defaultColor,
                                  fontFamily: 'intervalFont'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Adaptive.h(1)),
                          child: defaultBtn(
                              txt: "Checkout",
                              function: () {
                                defaultToast(
                                    msg: 'Thanks For Your Order',
                                    backgroundColor: Colors.blueGrey);
                              },
                              borderRadius: 13),
                        )
                      ],
                    )),
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCartItem(buyProductsCubit, index);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: Adaptive.h(.8),
                              ),
                          itemCount: buyProductsCubit.myCartProducts.length)
                    ],
                  ));
      },
    );
  }

  Widget buildCartItem(BuyProductsCubit buyProductsCubit, index) {
    return Column(
      children: [
        SizedBox(
          height: Adaptive.h(3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 7,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: Adaptive.h(3.5)),
                width: Adaptive.w(85),
                height: Adaptive.h(17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buyProductsCubit.myCartProducts[index].imageUrl
                            .contains('assets')
                        ? Image(
                            image: AssetImage('assets/images/tree.png'),
                          )
                        : Container(
                            alignment: AlignmentDirectional.center,
                            child: Image(
                              image: NetworkImage(buyProductsCubit
                                  .myCartProducts[index].imageUrl),
                              width: Adaptive.w(33),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(left: Adaptive.w(3.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: Adaptive.w(36),
                            child: defaultText(
                                text:
                                    buyProductsCubit.myCartProducts[index].name,
                                linesMax: 1,
                                textOverflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: Adaptive.h(1),
                          ),
                          defaultText(
                              text:
                                  '${buyProductsCubit.myCartProducts[index].totalProductPrice} EGP',
                              textColor: defaultColor,
                              fontSize: 15),
                          SizedBox(
                            height: Adaptive.h(2),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Adaptive.h(2)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              children: [
                                myIconButton(
                                    icon: Icons.remove,
                                    onPressed: () {
                                      buyProductsCubit
                                          .decrementCartProductQuantity(index);
                                    }),
                                defaultText(
                                    text:
                                        '${buyProductsCubit.myCartProducts[index].quantity}',
                                    fontSize: 18,
                                    textColor: Colors.black),
                                myIconButton(
                                    icon: Icons.add,
                                    onPressed: () {
                                      buyProductsCubit
                                          .incrementCartProductQuantity(index);
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    myIconButton(
                        icon: Icons.delete,
                        onPressed: () {
                          buyProductsCubit.removeProduct(index);
                        },
                        size: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
