import 'package:TutorialApp/Constants/constant_widgets.dart';
import 'package:TutorialApp/Constants/constants.dart';
import 'package:TutorialApp/Screens/PostDetailsScreen.dart';
import 'package:TutorialApp/ViewModels/CategoryListViewModel.dart';
import 'package:TutorialApp/ViewModels/PostListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SelectPostScreen extends StatefulWidget {
  final String subCatId;

  const SelectPostScreen({Key key, this.subCatId}) : super(key: key);
  @override
  _SelectPostScreenState createState() => _SelectPostScreenState();
}

class _SelectPostScreenState extends State<SelectPostScreen> {
  var categoryList = <Post>[].obs;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  getCategoryList() async {
    PostListViewModel objCategoryViewModel = PostListViewModel();

    var resp = await objCategoryViewModel
        .postListApiCall({"subcat_id": widget.subCatId});

    if (resp != null) {
      print(resp);
      categoryList.addAll(resp.post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.to(
                    () => PostDetailsScreen(
                          postID: categoryList[index].id,
                        ),
                    transition: transition),
                child: Container(
                  height: 20.0.h,
                  margin: EdgeInsets.all(2.0.h),
                  decoration: customBoxDecoration(
                      isimageBg: true,
                      bgImage: categoryList[index].bannerImg ?? "",
                      // color: primaryColor,
                      isBoxShadow: false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      text(
                        categoryList[index].title,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                      // Expanded(
                      //   child: Container(
                      //     alignment: Alignment.bottomLeft,
                      //     padding: EdgeInsets.only(left: 2.0.h),
                      //     child: ShaderMask(
                      //       shaderCallback: (rect) {
                      //         return LinearGradient(
                      //           begin: Alignment.topCenter,
                      //           end: Alignment.bottomCenter,
                      //           colors: [Colors.black, Colors.transparent],
                      //         ).createShader(
                      //             Rect.fromLTRB(0, 0, rect.width, rect.height));
                      //       },
                      //       blendMode: BlendMode.dstIn,
                      //       child: text(categoryList[index].title,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 30.0,
                      //           color: colorWhite.withOpacity(0.0)),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              itemCount: categoryList.length,
            )));
  }
}
