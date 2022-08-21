class PostsModel {
  String type = "", message = "";
  List<PostsData> postsData = [];

  PostsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    json['data'].forEach((obj) {
      postsData.add(PostsData.fromJson(obj));
    });
  }
}

class PostsData {
  String forumId = "", title = "", description = "", imageUrl = "", userId = "";

  PostsData.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    title = json['title'];
    description = json['description'];
    if (json['imageUrl'] != null) {
      imageUrl = json['imageUrl'];
    }
    userId = json['userId'];
  }
}
