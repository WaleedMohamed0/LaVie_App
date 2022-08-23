import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/cubits/app_cubit/cubit.dart';
import 'package:life/cubits/app_cubit/states.dart';
import 'package:life/screens/home_layout/home_layout.dart';

class FreeSeedScreen extends StatelessWidget {
  const FreeSeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addressController = TextEditingController();
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/freeSeed.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.6,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/LaVie.png'),
                        defaultText(
                            text: 'Get Seeds For Free',
                            fontSize: 40,
                            fontFamily: 'Karantina',
                            wordSpacing: 2.5),
                        defaultTextField(
                          txtinput: TextInputType.text,
                          labeltxt: "Address",
                          controller: addressController,
                        ),
                        defaultBtn(
                            txt: 'Send',
                            function: () {
                              appCubit.claimFreeSeeds(
                                  address: addressController.text);
                              navigateAndFinish(context, HomeLayout());
                            },),
                        defaultBtn(
                            txt: 'Save For Later',
                            function: ()
                            {
                              navigateAndFinish(context, HomeLayout());
                            },
                            textColor: HexColor('979797'),
                            backgroundColor: HexColor('F0F0F0')),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
