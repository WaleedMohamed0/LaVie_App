class UserModel {
  String? id;
  String? type;
  String? firstName;
  String? lastName;
  String? email;
  String? message;
  String? imageUrl;
  String? accessToken;
  // List<NotificationData> notificationData = [];

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];

    if (message == 'User updated successfully' ||
        message == "User fetched successfully") {
      id = json['data']['userId'];
      firstName = json['data']['firstName'];
      lastName = json['data']['lastName'];
      email = json['data']['email'];
      imageUrl = json['data']['imageUrl'];
    }
     else if (message == 'Logged in Successfully' ||
        message == 'User created successfully') {
      id = json['data']['user']['userId'];
      firstName = json['data']['user']['firstName'];
      lastName = json['data']['user']['lastName'];
      email = json['data']['user']['email'];
      imageUrl = json['data']['user']['imageUrl'];
      accessToken = json['data']['accessToken'];
    }
  }
}
//
// class NotificationData {
//   String notificationId = "",
//       userId = "",
//       imageUrl = "",
//       message = "",
//       createdAt = "";
//
//   NotificationData.fromJson(Map<String, dynamic> json) {
//     notificationId = json['notificationId'];
//     userId = json['userId'];
//     if (json['imageUrl'] != "") {
//       imageUrl = json['imageUrl'];
//     }
//     message = json['message'];
//     createdAt = json['createdAt'];
//   }
// }
