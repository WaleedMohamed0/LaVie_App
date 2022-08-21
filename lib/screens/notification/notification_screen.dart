import 'package:flutter/material.dart';
import 'package:life/components/components.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: defaultText(text: 'Notification'),
      ),
    );
  }
}
