import '../API/API.dart';

class PostListApiResponse {
  List<Post> post;

  PostListApiResponse({this.post});

  PostListApiResponse.fromJson(List json) {
    if (json != null) {
      post = <Post>[];
      json.forEach((v) {
        post.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['data'] = this.post.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String id;
  String title;
  String subtitle;
  String bannerImg;

  Post({this.id, this.title, this.subtitle, this.bannerImg});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['banner_img'] = this.bannerImg;
    return data;
  }
}

class PostListViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<PostListApiResponse> postListApiCall(Map parameters) async {
    var json = await apiHelper.post("postlist", parameters);
    var response = new PostListApiResponse.fromJson(json);
    print(response.post.length);
    return response;
  }
}
