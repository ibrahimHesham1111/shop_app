class CategoriesModel
{
  bool? status;
  CategoriesModelData? data;

  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data = json['data'] != null ? CategoriesModelData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CategoriesModelData
{
  int? currentPage;
  List<DataModel>data=[];

  CategoriesModelData.fromJson(Map<String,dynamic>json)
  {
    currentPage=json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data.add(DataModel.fromJson(v));
      });
    }

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class DataModel
{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;


    return data;
  }
}