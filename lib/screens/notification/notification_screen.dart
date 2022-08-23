import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:life/components/components.dart';
import 'package:life/models/notification_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notifications = [];
    notifications.addAll(notificationList);
    notifications.addAll(notificationList);
    return Scaffold(
        appBar: defaultAppBar(title: 'Notification'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      // if (index == notificationList.length - 1) {
                      //   index = index % (notificationList.length - 1);
                      // }
                      return buildNotification(notifications[index]);
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                    itemCount: notifications.length),
              ),
            ],
          ),
        ));
  }

  Widget buildNotification(NotificationModel notification) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2),vertical: Adaptive.h(2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              notification.imageUrl,
            ),
            SizedBox(
              width: Adaptive.w(3.5),
            ),
            SizedBox(
              width: Adaptive.w(72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultText(
                      text: notification.title,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                      textColor: HexColor('1A1F36')),
                  SizedBox(
                    height: Adaptive.h(.5),
                  ),
                  if (notification.text != "")
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          VerticalDivider(
                            thickness: 3,
                            width: 20,
                            color: HexColor('DDDEE1'),
                          ),
                          Flexible(
                              child: defaultText(
                                  text: notification.text,
                                  textColor: HexColor('1A1F36'),
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: Adaptive.h(.5),
                  ),
                  defaultText(
                      text: notification.time, textColor: HexColor('A5ACB8'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
