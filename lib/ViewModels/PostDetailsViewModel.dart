import '../API/API.dart';

class PostDetailsApiResponse {
  PostDetails postDetails;

  PostDetailsApiResponse({this.postDetails});

  PostDetailsApiResponse.fromJson(Map<String, dynamic> json) {
    postDetails = new PostDetails.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postDetails != null) {
      data['data'] = this.postDetails.toJson();
    }
    return data;
  }
}

class PostDetails {
  String id;
  String title;
  String subtitle;
  String bannerImg;
  String content;

  PostDetails(
      {this.id, this.title, this.subtitle, this.bannerImg, this.content});

  PostDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    bannerImg = json['banner_img'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['banner_img'] = this.bannerImg;
    data['content'] = this.content;
    return data;
  }
}

class PostDetailsViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<PostDetailsApiResponse> postDetailsApiCall(Map parameters) async {
    var json = await apiHelper.post("postDetails", parameters);
    print("json" + json.toString());
    var response = new PostDetailsApiResponse.fromJson(json);
    print("Response" + response.postDetails.toString());
    return response;
  }
}
