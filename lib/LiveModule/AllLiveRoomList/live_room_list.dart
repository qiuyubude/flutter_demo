import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor_site/api.dart';
import 'package:doctor_site/public_methods.dart';

import 'package:demo/LiveModule/AllLiveRoomList/living_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:demo/LiveModule/models/all_studio_list_model.dart';

class LiveRoomList extends StatefulWidget {
  @override
  _LiveRoomListState createState() => _LiveRoomListState();
}

class _LiveRoomListState extends State<LiveRoomList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '全部直播间',
          style: TextStyle(color: Colors.black),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(0),
        child: ContentListView(),
      ),
    );
  }
}

class ContentListView extends StatefulWidget {
  @override
  _ContentListViewState createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView> {
  List<Allstudiolistmodel> dataList = [];
  bool isEnd = false;
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    getDataList(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: EasyRefresh(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 0), () {
            setState(() {
              this.getDataList(true);
              // getHttp();
            });
            _controller.resetLoadState();
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 0), () {
            this.getDataList(false);
          });
        },
        controller: _controller,
        enableControlFinishLoad: true,
        enableControlFinishRefresh: false,
        child: new ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                child: buildListViewContent(context, dataList[index]),
              );
            }),
      ),
    );
  }

  Widget buildListViewContent(BuildContext context, Allstudiolistmodel model) {
    return Container(
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              studioImgWidget(model.studioImg),
              Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            livingIconWidget(model.living),
                            studioTitleWidget(model.studioTitle, model.living),
                          ],
                        ),
                        Row(
                          children: [
                            studioIntroWidget(model.studioIntro),
                          ],
                        ),
                        Row(
                          children: [
                            fansWidget(model),
                            focusButtonWiget(model),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

// 直播间封面
  Widget studioImgWidget(String studioImg) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FadeInImage(
          placeholder: AssetImage('assets/images/Live/livingRoom.png'),
          image: NetworkImage(studioImg),
          width: 60,
          height: 60,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

// 直播中标识
  Widget livingIconWidget(int living) {
    if (living > 0) {
      return Container(
        padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
        child: LivingIconView(
          showImg: true,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      );
    }
  }

// 直播间标题
  Widget studioTitleWidget(String studioTitle, int living) {
    EdgeInsets edg = EdgeInsets.fromLTRB(6, 10, 15, 0);
    if (living == 0) edg = EdgeInsets.fromLTRB(12, 10, 15, 0);
    return Expanded(
        child: Container(
      padding: edg,
      child: Text(
        studioTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 34, 34, 34)),
      ),
    ));
  }

// 直播间简介
  Widget studioIntroWidget(String studioIntro) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.fromLTRB(12, 8, 15, 0),
      child: Text(
        studioIntro,
        maxLines: 2,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(fontSize: 14, color: Color.fromARGB(255, 102, 102, 102)),
      ),
    ));
  }

// 粉丝数 视频数 人气
  Widget fansWidget(Allstudiolistmodel model) {
    return Expanded(
      child: Container(
        width: 100,
        padding: EdgeInsets.fromLTRB(12, 8, 0, 10),
        child: Text(
          '粉丝 ${PublicMethods.formatUserCount(model.fansNum)}   视频 ${PublicMethods.formatUserCount(model.subjectNum)}  \n人气 ${PublicMethods.formatUserCount(model.hots)}',
          style: TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
        ),
      ),
    );
  }

// 关注按钮
  Widget focusButtonWiget(Allstudiolistmodel model) {
    Color textColor = Color.fromARGB(255, 233, 63, 53);
    String text = '关注';
    if (model.isFans) {
      text = '已关注';
      textColor = Color.fromARGB(255, 204, 204, 204);
    }
    Widget getFocusText(isFans) {
      return Container(
        //边框设置
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(11.0)),
          //设置四周边框
          border: new Border.all(width: 0.5, color: textColor),
        ),
        child: GestureDetector(
          child: Text(
            text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: textColor, fontFamily: 'MediumItalic'),
          ),
          onTap: () {
            focusStudioWithModel(model);
          },
        ),
      );
    }

    return SizedBox(
      width: 75,
      height: 22,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: getFocusText(model.isFans),
      ),
    );
  }

// 关注|取消关注直播间
  void focusStudioWithModel(Allstudiolistmodel model) async {
    var postParams = {
      "studioId": model.studioId,
      "isSubscribe": !model.isFans,
    };
    try {
      Api.getInstance().apiEvn = ApiEnv.ApiEnvTest;
      Api.getInstance().uid = 6602;
      Api.getInstance().guid = '7ced64b422994fbfa052b920067894d2';
      Api.getInstance().session = '9702020840080516';

      var response = await Api.getInstance()
          .postReqeust("studio/subscribeStudio", postParams);
      var body = response["body"];
      int points = body["points"];
      int fansNum = body["fansNum"];
      String msg = '';
      setState(() {
        model.isFans = !model.isFans;
        model.fansNum = fansNum;
        if (!model.isFans) {
          //取消关注直播间
          msg = '取消关注成功';
        } else {
          // 关注直播间
          msg = '关注成功';
        }
      });
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER, // 消息框弹出的位置
          // timeInSecForIos: 1,  // 消息框持续的时间（目前的版本只有ios有效）
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print(e);
    }
  }

// 获取全部直播间列表数据
  void getDataList(bool isRefresh) async {
    var postParams = {
      "start": (isRefresh ? 0 : dataList.length),
      "limit": (20),
    };
    try {
      Api.getInstance().apiEvn = ApiEnv.ApiEnvTest;
      Api.getInstance().uid = 6602;
      Api.getInstance().guid = '7ced64b422994fbfa052b920067894d2';
      Api.getInstance().session = '9702020840080516';

      var response = await Api.getInstance()
          .postReqeust("studio/getRecommendStudioList", postParams);
      var body = response["body"];
      var list = body["list"];
      isEnd = body["isEnd"];

      List<Allstudiolistmodel> mList = [];
      for (var json in list) {
        Map<String, dynamic> mapJson = json;
        Allstudiolistmodel model = Allstudiolistmodel.fromJson(mapJson);
        mList.add(model);
      }
      setState(() {
        if (isRefresh) {
          dataList = mList;
        } else {
          dataList.addAll(mList);
        }
        if (isEnd) {
          this._controller.finishLoad(success: true, noMore: true);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

// bool isEnd = false;
// bool isLoading = false;
// List<Allstudiolistmodel> _dataList = [];
// ScrollController _scrollController = new ScrollController();

// class _ContentListViewState extends State<ContentListView> {
//   @override
//   void initState() {
//     super.initState();
//     getDataList(true);
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _scrollController.dispose();
//   // }

//   Widget buildListData(BuildContext context, Allstudiolistmodel model) {
//     Color textColor = Color.fromARGB(255, 233, 63, 53);
//     if (model.isFans) {
//       textColor = Color.fromARGB(255, 204, 204, 204);
//     }
//     return Container(
//       color: Colors.white,
//       child: Column(
//         children: <Widget>[
//           new Flex(
//             direction: Axis.horizontal,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: FadeInImage(
//                           placeholder:
//                               AssetImage('assets/images/My/nomal_pic.png'),
//                           image: NetworkImage(model.studioImg),
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.fill,
//                         ),
//                       ))
//                 ],
//               ),
//               Expanded(
//                   child: Container(
//                 padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 12.0, top: 12.0),
//                         child: Container(
//                           child: LivingIconView(
//                             showImg: true,
//                           ),
//                           width: 56,
//                           height: 18,
//                         ),
//                       ),
//                       Expanded(
//                           child: Container(
//                         padding: EdgeInsets.fromLTRB(6, 10, 15, 0),
//                         child: Text(
//                           model.studioTitle,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 34, 34, 34)),
//                         ),
//                       )),
//                     ]),
//                     Row(
//                       children: [
//                         Expanded(
//                           /// 副标题
//                           child: Container(
//                             padding: EdgeInsets.fromLTRB(12, 8, 15, 0),
//                             child: Text(
//                               model.studioIntro,
//                               maxLines: 2,
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 102, 102, 102)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Container(
//                           width: 100,
//                           padding: EdgeInsets.fromLTRB(12, 8, 80, 10),
//                           child: Text(
//                             '粉丝 ${formatUserCount(model.fansNum)}   视频 ${formatUserCount(model.subjectNum)}  \n人气 ${formatUserCount(model.hots)}',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color.fromARGB(255, 153, 153, 153)),
//                           ),
//                         )),
//                         Container(
//                           width: 75,
//                           height: 22,
//                           padding: EdgeInsets.only(right: 15),
//                           child: OutlineButton(
//                             color: Colors.white,
//                             child: getFocusText(model.isFans),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(11.0),
//                             ),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 0.5),
//                             onPressed: () {},
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget getFocusText(isFans) {
//     String text = '关注';
//     Color textColor = Color.fromARGB(255, 233, 63, 53);
//     if (isFans) {
//       text = '已关注';
//       textColor = Color.fromARGB(255, 204, 204, 204);
//     }
//     return Container(
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 14, color: textColor),
//       ),
//     );
//   }

//   String formatUserCount(count) {
//     String countStr;
//     if (count >= 10000) {
//       double i = count / 10000;
//       double j = (count - i * 10000) * 10 / 10000;

//       countStr = '${i.toStringAsFixed(0)}.${j.toStringAsFixed(0)} 万';
//     } else {
//       countStr = '${count.toString()} ';
//     }
//     return countStr;
//   }

//   @override
//   Widget build(BuildContext context) {
//     _scrollController.addListener(() {
//       var maxScroll = _scrollController.position.maxScrollExtent;
//       var pixel = _scrollController.position.pixels;
//       if (maxScroll == pixel && !isEnd && !isLoading) {
//         setState(() {
//           isLoading = true;
//           getDataList(false);
//         });
//       }
//     });
//     return RefreshIndicator(
//       displacement: 44.0,
//       color: Colors.white,
//       child: new ListView.builder(
//         itemBuilder: (context, index) {
//           if (isEnd) {
//             return new Container(
//               padding: EdgeInsets.all(16.0),
//               alignment: Alignment.center,
//               child: new Text(
//                 '我是有底线的!!!',
//                 style: TextStyle(color: Colors.blue),
//               ),
//             );
//           } else {
//             Allstudiolistmodel model = _dataList[index];
//             return new Container(
//               child: new Column(
//                 children: <Widget>[
//                   buildListData(context, model),
//                 ],
//               ),
//             );
//           }
//         },
//         itemCount: _dataList.length,
//         controller: _scrollController,
//       ),
//       onRefresh: () async {
//         await Future.delayed(Duration(seconds: 0), () {
//           setState(() {
//             this.getDataList(true);
//           });
//           // _controller.resetLoadState();
//         });
//       },
//     );
//   }
