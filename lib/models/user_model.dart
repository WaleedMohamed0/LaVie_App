class UserModel {
  String? id;
  String? type;
  String? firstName;
  String? lastName;
  String? email;
  String? message;
  String? imageUrl;
  String? accessToken;

  UserModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if(message == 'User updated successfully' || message == "User fetched successfully")
      {
        id = json['data']['userId'];
        firstName = json['data']['firstName'];
        lastName = json['data']['lastName'];
        email = json['data']['email'];
        imageUrl = json['data']['imageUrl'];
      }
    else if (message == 'Logged in Successfully')
      {
        id = json['data']['user']['userId'];
        firstName = json['data']['user']['firstName'];
        lastName = json['data']['user']['lastName'];
        email = json['data']['user']['email'];
        imageUrl = json['data']['user']['imageUrl'];
        accessToken = json['data']['accessToken'];
      }

  }
}
