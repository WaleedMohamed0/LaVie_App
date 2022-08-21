import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/constants/constants.dart';

void navigateTo(context, nextPage) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

void navigateAndFinish(context, nextPage) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
    (route) => false);

Widget defaultTextField({
  String? labeltxt,
  Icon? prefixIcon,
  bool isPass = false,
  IconData? suffix,
  TextEditingController? controller,
  required TextInputType txtinput,
  Function()? SuffixPressed,
  Function(String val)? onSubmit,
  Function(String value)? valid,
  TextStyle? hintStyle,
  int maxLines = 1,
}) {
  return TextFormField(
    maxLines: maxLines,
    textAlignVertical: TextAlignVertical.top,
    keyboardType: txtinput,
    controller: controller,
    onFieldSubmitted: onSubmit,
    obscureText: isPass,
    decoration: InputDecoration(
      alignLabelWithHint: true,
      hintStyle: hintStyle,
      hintText: labeltxt,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.green, width: 2)),
      prefixIcon: prefixIcon,
      suffixIcon: IconButton(
        icon: Icon(
          suffix,
          color: defaultColor,
        ),
        onPressed: SuffixPressed,
      ),
    ),
    validator: (value) {
      valid!;
    },
  );
}

Widget searchTextField({
  required Function(String searchQuery) onSubmit,
}) =>
    TextFormField(
      keyboardType: TextInputType.text,
      onFieldSubmitted: (String searchQuery) {
        onSubmit(searchQuery);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(32, 10, 10, 10),
          child: Icon(
            Icons.search,
          ),
        ),
        hintText: "Search",
        hintStyle: TextStyle(color: HexColor('979797')),
        fillColor: HexColor('F8F8F8'),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white, width: 10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white, width: 10),
        ),
      ),
    );

Widget defaultText(
        {required String text,
        double? fontSize,
        double? letterSpacing,
        isUpperCase = false,
        textColor,
        double? textHeight,
        double? wordSpacing,
        linesMax,
        TextOverflow? textOverflow,
        FontStyle? fontStyle,
        TextStyle? hintStyle,
        TextAlign? textAlign,
        FontWeight? fontWeight,
        String? fontFamily,
        TextStyle? myStyle}) =>
    Text(
      isUpperCase ? text.toUpperCase() : text,
      maxLines: linesMax,
      overflow: textOverflow,
      textAlign: textAlign,
      style: myStyle ??
          TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              color: textColor,
              fontWeight: fontWeight,
              height: textHeight,
              fontStyle: fontStyle,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing),
    );

Widget defaultTextButton(
        {required String text,
        required VoidCallback fn,
        double? fontSize,
        textColor,
        FontWeight? fontWeight,
        bool isUpper = true}) =>
    TextButton(
        onPressed: fn,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
              fontSize: fontSize, color: textColor, fontWeight: fontWeight),
        ));

Widget defaultBtn({
  double width = 330,
  Color backgroundColor = defaultColor,
  Color textColor = Colors.white,
  bool isUpperCase = false,
  double borderRadius = 10,
  required String txt,
  required VoidCallback function,
  IconData? icon,
  double fontSize = 20,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return Container(
    width: width,
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        isUpperCase ? txt.toUpperCase() : txt,
        style:
            TextStyle(fontSize: fontSize, color: textColor, letterSpacing: 1.5),
      ),
    ),
  );
}

Widget myDivider() => Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    );

Future myDialog(
        {context,
        required text,
        declineText,
        acceptText,
        Widget? content,
        String? labelTxt1,
        String? labelTxt2,
        TextEditingController? controller1,
        TextEditingController? controller2,
        bool isItListView = false,
        bool changeName = false,
        void Function()? declineFn,
        void Function()? acceptFn}) =>
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultText(text: text, fontSize: 17),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      defaultTextField(
                          txtinput: TextInputType.text,
                          controller: controller1,
                          labeltxt: labelTxt1),
                      SizedBox(
                        height: 15,
                      ),
                      changeName
                          ? defaultTextField(
                              txtinput: TextInputType.text,
                              controller: controller2,
                              labeltxt: labelTxt2)
                          : Container(),
                    ],
                  ),
                ],
              ),
              content: isItListView
                  ? content
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: TextButton(
                              onPressed: declineFn,
                              child: defaultText(
                                  text: declineText, textColor: Colors.white)),
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor,
                          ),
                        ),
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor,
                          ),
                          child: TextButton(
                              onPressed: acceptFn,
                              child: defaultText(
                                  text: acceptText, textColor: Colors.white)),
                        ),
                      ],
                    ));
        });

Widget myIconButton(
        {required IconData icon,
        double size = 22,
        Color color = defaultColor,
        required Function onPressed,
        EdgeInsets padding = EdgeInsets.zero}) =>
    IconButton(
        hoverColor: transparentColor,
        splashColor: transparentColor,
        highlightColor: transparentColor,
        padding: padding,
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon, size: size, color: color));

AppBar defaultAppBar(
        {String title = "",
        FontWeight? fontWeight = FontWeight.w600,
        Color textColor = Colors.black,
        double? fontSize,
        List<Widget>? actions,
        Color foregroundColor = Colors.black,
        double? elevation,
        Color? backgroundColor}) =>
    AppBar(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      actions: actions,
      elevation: elevation,
      title: defaultText(
          text: title,
          fontWeight: fontWeight,
          textColor: textColor,
          fontSize: fontSize),
      centerTitle: true,
    );

Future<bool?> defaultToast(
        {required String msg,
        Color textColor = Colors.white,
        Color backgroundColor = defaultColor}) =>
    Fluttertoast.showToast(
        msg: msg, textColor: textColor, backgroundColor: backgroundColor);
