class ProductsModel {
  List<ProductsData> plantsData = [];
  List<ProductsData> seedsData = [];
  List<ProductsData> toolsData = [];

  ProductsModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((obj) {
      if (obj['type'] == "PLANT") {
        plantsData.add(PlantsData.fromJson(obj));
      }
      if (obj['type'] == "SEED") {
        seedsData.add(SeedsData.fromJson(obj));
      }
      if (obj['type'] == "TOOL") {
        toolsData.add(ToolsData.fromJson(obj));
      }
    });
  }
}

class ProductsData {
  String id = "", description = "", name = "", imageUrl = "";
  int price = 0,waterCapacity = 0, sunLight = 0, temperature = 0;
}

class PlantsData extends ProductsData {

  PlantsData.fromJson(Map<String, dynamic> json) {
    id = json['plant']['plantId'];
    price = json['price'];
    name = json['plant']['name'];
    description = json['plant']['description'];
    if (json['plant']['imageUrl'] != "") {
      imageUrl += json['plant']['imageUrl'];
    }
    waterCapacity = json['plant']['waterCapacity'];
    sunLight = json['plant']['sunLight'];
    temperature = json['plant']['temperature'];
  }
}

class SeedsData extends ProductsData {
  SeedsData.fromJson(Map<String, dynamic> json) {
    id = json['seed']['seedId'];
    price = json['price'];
    name = json['seed']['name'];
    description = json['seed']['description'];
    if (json['seed']['imageUrl'] != "") {
      imageUrl += json['seed']['imageUrl'];
    }
  }
}

class ToolsData extends ProductsData {
  ToolsData.fromJson(Map<String, dynamic> json) {
    id = json['tool']['toolId'];
    price = json['price'];
    name = json['tool']['name'];
    description = json['tool']['description'];
    if (json['tool']['imageUrl'] != "") {
      imageUrl += json['tool']['imageUrl'];
    }
  }
}
