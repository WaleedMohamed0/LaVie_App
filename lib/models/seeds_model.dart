class SeedsModel
{
  String? type;
  String? message;
  List<SeedsData> seedsData=[];
  SeedsModel.fromJson(Map<String,dynamic>json)
  {
    json['data'].forEach((obj)
    {
      seedsData.add(SeedsData.fromJson(obj));
    });
  }


}
class SeedsData
{
  String? seedsId;
  String? name;
  String? desc;
  String? imageUrl;
  SeedsData.fromJson(Map<String,dynamic> json)
  {
    seedsId = json['seedId'];
    name = json['name'];
    desc = json['description'];
    seedsId = json['seedId'];
    imageUrl = json['imageUrl'];
  }
}