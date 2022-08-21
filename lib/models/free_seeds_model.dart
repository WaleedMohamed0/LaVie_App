class FreeSeedsModel
{
  String type ="",message = "";

  FreeSeedsModel.fromJson(Map<String,dynamic>json)
  {
    type=json['type'];
    message=json['message'];
  }
}