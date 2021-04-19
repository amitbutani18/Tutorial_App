import '../API/API.dart';

class LoginResponse {
  String id;
  String fName;
  String lName;
  String email;
  String userType;
  String groupId;

  LoginResponse({this.id, this.fName, this.lName, this.email, this.userType});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    userType = json['user_type'];
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    data['group_id'] = this.groupId;
    return data;
  }
}

class SignInViewModel {
  ApiBaseHelper apiHelper = ApiBaseHelper();

  Future<LoginResponse> loginApiCall(Map parameters) async {
    var json = await apiHelper.post("login", parameters, isShow: true);
    var response = new LoginResponse.fromJson(json);
    print(response.id);
    return response;
  }
}
