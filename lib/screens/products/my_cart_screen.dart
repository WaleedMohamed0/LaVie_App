import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:life/components/components.dart';
import 'package:life/constants/constants.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: defaultAppBar(
                title: "My Cart",
                elevation: 0,
                backgroundColor: Colors.grey[50]),
            body: appCubit.myCartProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/Frame.png')),
                        SizedBox(
                          height: 15,
                        ),
                        defaultText(
                            text: 'Your cart is empty',
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                : FooterView(
                    flex: appCubit.myCartProducts.length > 1 ? 6 : 3,
                    footer: Footer(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Row(
                            children: [
                              defaultText(
                                  text: "Total",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              Spacer(),
                              defaultText(
                                  text:
                                      "${appCubit.totalPrice} EGP",
                                  fontSize: 18,
                                  textColor: defaultColor,
                                  fontFamily: 'intervalFont'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: defaultBtn(
                              txt: "Checkout",
                              function: () {},
                              borderRadius: 13),
                        )
                      ],
                    )),
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCartItem(appCubit, index);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                          itemCount: appCubit.myCartProducts.length)
                    ],
                  ));
      },
    );
  }

  Widget buildCartItem(AppCubit appCubit, index) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 7,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 340,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    appCubit.myCartProducts[index].imageUrl.contains('assets')
                        ? Image(
                            image: AssetImage('assets/images/tree.png'),
                          )
                        : Container(
                            alignment: AlignmentDirectional.center,
                            child: Image(
                              image: NetworkImage(
                                  appCubit.myCartProducts[index].imageUrl),
                              width: 120,
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: defaultText(
                                text: appCubit.myCartProducts[index].name,
                                linesMax: 1,
                                textOverflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            // width: 170,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          defaultText(
                              text:
                                  '${appCubit.myCartProducts[index].totalProductPrice} EGP',
                              textColor: defaultColor,
                              fontSize: 15),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              children: [
                                myIconButton(
                                    icon: Icons.remove,
                                    onPressed: () {
                                      appCubit
                                          .decrementCartProductQuantity(index);
                                    }),
                                defaultText(
                                    text:
                                        '${appCubit.myCartProducts[index].quantity}',
                                    fontSize: 18,
                                    textColor: Colors.black),
                                myIconButton(
                                    icon: Icons.add,
                                    onPressed: () {
                                      appCubit
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
                          appCubit.removeProduct(index);
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
