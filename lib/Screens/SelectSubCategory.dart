import 'package:TutorialApp/Constants/constant_widgets.dart';
import 'package:TutorialApp/Constants/constants.dart';
import 'package:TutorialApp/Screens/SelectPostScreen.dart';
import 'package:TutorialApp/ViewModels/CategoryListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'SelectSubCategory.dart';

class SelectSubCategory extends StatefulWidget {
  final String catId;

  const SelectSubCategory({Key key, this.catId}) : super(key: key);
  @override
  _SelectSubCategoryState createState() => _SelectSubCategoryState();
}

class _SelectSubCategoryState extends State<SelectSubCategory> {
  var categoryList = <Category>[].obs;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  getCategoryList() async {
    SubCategoryViewModel objCategoryViewModel = SubCategoryViewModel();

    var resp = await objCategoryViewModel
        .subCategoryListApiCall({"cat_id": widget.catId});

    if (resp != null) {
      print(resp);
      categoryList.addAll(resp.category);
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
                    () => SelectPostScreen(
                          subCatId: categoryList[index].id,
                        ),
                    transition: transition),
                child: Container(
                  height: 20.0.h,
                  margin: EdgeInsets.all(2.0.h),
                  decoration: customBoxDecoration(
                      color: primaryColor.withOpacity(0.8), isBoxShadow: false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 2.0.h),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: text(categoryList[index].name,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: colorWhite.withOpacity(1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: categoryList.length,
            )));
  }
}
