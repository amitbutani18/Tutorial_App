import '../API/API.dart';

class CategoryListApiResponse {
  List<Category> category;

  CategoryListApiResponse({this.category});

  CategoryListApiResponse.fromJson(List json) {
    if (json != null) {
      category = <Category>[];
      json.forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['data'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String id;
  String name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class CategoryViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<CategoryListApiResponse> categoryListApiCall(Map parameters) async {
    var json = await apiHelper.post("categories", parameters);
    var response = new CategoryListApiResponse.fromJson(json);
    print(response.category.length);
    return response;
  }
}

class SubCategoryViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<CategoryListApiResponse> subCategoryListApiCall(Map parameters) async {
    var json = await apiHelper.post("subCategories", parameters);
    var response = new CategoryListApiResponse.fromJson(json);
    print(response.category.length);
    return response;
  }
}
