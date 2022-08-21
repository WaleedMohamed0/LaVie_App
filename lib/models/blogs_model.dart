class BlogsModel {
  List<BlogsData> plantsData = [];
  List<BlogsData> seedsData = [];
  List<BlogsData> toolsData = [];

  BlogsModel.fromJson(Map<String, dynamic> json) {
    json['data']['plants'].forEach((obj) {
      plantsData.add(PlantsData.fromJson(obj));
    });
    json['data']['seeds'].forEach((obj) {
      seedsData.add(SeedsData.fromJson(obj));
    });
    json['data']['tools'].forEach((obj) {
      plantsData.add(ToolsData.fromJson(obj));
    });
  }
}

class BlogsData {
  String id = "", description = "", name = "", imageUrl = "";
}

class PlantsData extends BlogsData {
  int waterCapacity = 0, sunLight = 0, temperature = 0;

  PlantsData.fromJson(Map<String, dynamic> json) {
    id = json['plantId'];
    name = json['name'];
    description = json['description'];
    if (json['imageUrl'] != "") {
      imageUrl += json['imageUrl'];
    }
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }
}

class SeedsData extends BlogsData {
  SeedsData.fromJson(Map<String, dynamic> json) {
    id = json['seedId'];
    name = json['name'];
    description = json['description'];
    if (json['imageUrl'] != "") {
      imageUrl += json['imageUrl'];
    }
  }
}

class ToolsData extends BlogsData {
  ToolsData.fromJson(Map<String, dynamic> json) {
    id = json['toolId'];
    name = json['name'];
    description = json['description'];
    if (json['imageUrl'] != "") {
      imageUrl += json['imageUrl'];
    }
  }
}
