import 'package:TutorialApp/Constants/constant_widgets.dart';
import 'package:TutorialApp/Constants/constants.dart';
import 'package:TutorialApp/ViewModels/PostDetailsViewModel.dart';
import 'package:TutorialApp/ViewModels/PostListViewModel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PostDetailsScreen extends StatefulWidget {
  final String postID;

  const PostDetailsScreen({Key key, this.postID}) : super(key: key);
  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  var categoryList = PostDetails().obs;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  getCategoryList() async {
    PostDetailsViewModel objCategoryViewModel = PostDetailsViewModel();
    var resp = await objCategoryViewModel
        .postDetailsApiCall({"post_id": widget.postID});
    if (resp != null) {
      print("Amiy" + resp.postDetails.id.toString());
      categoryList.value = resp.postDetails;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => WebView(
              initialUrl: Uri.dataFromString(categoryList.value.content,
                      mimeType: 'text/html')
                  .toString(),
            ))
        // _titleAndPointList(
        //     heading: "controller.selectedGameDetails.value.team1Name",
        //     data: categoryList.value.content),
        ;
  }

  Container _titleAndPointList({String heading, String data}) {
    return Container(
      decoration: customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // customHeading1(heading: heading),
          WebView(
            initialUrl: Uri.dataFromString(
                    '<html><body>hello world</body></html>',
                    mimeType: 'text/html')
                .toString(),

            // data: data,
            //
            // onLinkTap: (link) {
            //   print(link);
            // },
            // shrinkWrap: true,
          ),
          // itemCount: testData.length,
          // ),
        ],
      ),
    );
  }
}
