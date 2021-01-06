import 'dart:io';

import 'package:demo/Formula/Views/Models/formula_list_model.dart';
import 'package:demo/Formula/Views/Models/formula_second_list_model.dart';
import 'package:flutter/material.dart';
import 'package:doctor_site/api.dart';
import 'package:azlistview/azlistview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:device_info/device_info.dart';

class FormulaSecondList extends StatefulWidget {
  final FormulaListModel listModel;
  FormulaSecondList({Key key, this.listModel});

  @override
  _FormulaSecondListState createState() => _FormulaSecondListState();
}

class _FormulaSecondListState extends State<FormulaSecondList> {
  List<FormulaSecondListModel> dataList = [];
  List<String> indexDataList = [];
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  void initState() {
    super.initState();
    getDrugFormulaListByCategory();
  }

  // 获取列表数据
  void getDrugFormulaListByCategory() async {
    var postParams = {
      "categoryId": widget.listModel.categoryId,
    };
    try {
      Api.getInstance().apiEvn = ApiEnv.ApiEnvTest;
      Api.getInstance().uid = 6602;
      Api.getInstance().guid = '7ced64b422994fbfa052b920067894d2';
      Api.getInstance().session = '9702020840080516';

      var response = await Api.getInstance()
          .postReqeust("drug/getDrugFormulaListByCategory", postParams);
      var body = response["body"];
      var list = body["list"];

      List<FormulaSecondListModel> mList = [];
      for (var json in list) {
        Map<String, dynamic> mapJson = json;
        FormulaSecondListModel model = FormulaSecondListModel.fromJson(mapJson);
        String pinyin = PinyinHelper.getPinyinE(model.name);
        String tag = pinyin.substring(0, 1).toUpperCase();
        model.pinYinTag = pinyin;
        if (RegExp("[A-Z]").hasMatch(tag)) {
          model.pinYin = tag;
        } else {
          model.pinYin = "#";
        }
        model.isShowLine = true;
        mList.add(model);
      }
      // A-Z sort.
      // SuspensionUtil.sortListBySuspensionTag(mList);
      mList.sort((a, b) {
        return a.pinYinTag.toLowerCase().compareTo(b.pinYinTag.toLowerCase());
      });
      // show sus tag.
      SuspensionUtil.setShowSuspensionStatus(mList);
      // get index data list by suspension tag.
      indexDataList = SuspensionUtil.getTagIndexList(mList);

      for (int i = 0; i < mList.length; i++) {
        FormulaSecondListModel model = mList[i];
        if (i == mList.length - 1) {
          model.isShowLine = false;
        }
        if (model.isShowSuspension && i != 0) {
          // 表头前一根线隐藏
          mList[i - 1].isShowLine = false;
        }
      }

      if (Platform.isIOS) {
        // ios 平台底部添加一个假数据用于适配iPhone X系列
        FormulaSecondListModel model = FormulaSecondListModel();
        mList.add(model);
      }

      setState(() {
        dataList = mList;
      });
      if (itemScrollController.isAttached) {
        itemScrollController.jumpTo(index: 0);
      }
    } catch (e) {
      print(e);
    }
  }

  void jumpToFormulaDetailPage(FormulaSecondListModel model) {
    print('点击了 ${model.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.listModel.name,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        // 列表
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: AzListView(
            data: dataList,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: dataList.length,
            // 列表cell
            itemBuilder: (BuildContext context, int index) {
              if (index == dataList.length - 1) {
                return iphoneBottomWidget(context);
              }
              FormulaSecondListModel model = dataList[index];
              return getListItem(context, model);
            },
            // 表头
            itemScrollController: itemScrollController,
            susItemBuilder: (BuildContext context, int index) {
              FormulaSecondListModel model = dataList[index];
              return getSusItem(context, model.getSuspensionTag());
            },
            // 悬浮窗
            indexBarData: indexDataList,
            indexBarOptions: IndexBarOptions(
              needRebuild: true,
              selectTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              selectItemDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 222, 84, 85)),
              indexHintWidth: 50,
              indexHintHeight: 50,
              indexHintDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Home/ic_index_bar_bubble_gray.png'),
                  fit: BoxFit.contain,
                ),
              ),
              indexHintAlignment: Alignment.centerRight,
              indexHintChildAlignment: Alignment(-0.25, 0.0),
              indexHintTextStyle: TextStyle(
                  fontSize: 27.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              indexHintOffset: Offset(-10, 0),
            ),
          ),
        ));
  }

  ///构建悬停Widget.
  Widget getSusItem(BuildContext context, String tag, {double susHeight = 25}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0),
      color: Color.fromARGB(255, 248, 248, 248),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: true,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 51, 51, 51),
        ),
      ),
    );
  }

  ///构建列表cell Widget.
  Widget getListItem(BuildContext context, FormulaSecondListModel model,
      {double susHeight = 40}) {
    if (null != model.introduce) {
      // 简介不为空
      return GestureDetector(
        onTap: () {
          jumpToFormulaDetailPage(model);
        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [formulaTitleWidget(model.name)],
                          ),
                          Row(
                            children: [formulaIntroWidget(model.introduce)],
                          ),
                          Row(
                            children: [formulaLineWidget(model.isShowLine)],
                          )
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      // 简介为空
      return GestureDetector(
        onTap: () {
          jumpToFormulaDetailPage(model);
        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [formulaTitleWidget(model.name)],
                          ),
                          Row(
                            children: [formulaLineWidget(model.isShowLine)],
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
  }

  // 直播间标题
  Widget formulaTitleWidget(String formulaTitle) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Text(
        formulaTitle,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 51, 51, 51),
            fontWeight: FontWeight.w400),
      ),
    ));
  }

  // 直播间简介
  Widget formulaIntroWidget(String formulaIntro) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.fromLTRB(15, 4, 15, 0),
      child: Text(
        formulaIntro,
        maxLines: 1,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
      ),
    ));
  }

  // 线
  Widget formulaLineWidget(bool isShowLine) {
    Color color = Color.fromARGB(255, 210, 210, 210);
    if (isShowLine == false) {
      color = Color.fromARGB(1, 255, 255, 255);
    }
    return Expanded(
        child: Container(
      padding: EdgeInsets.fromLTRB(15, 14.5, 0, 0),
      child: Divider(
        height: 0.5,
        indent: 0,
        color: color,
      ),
    ));
  }

  // iPhone X 系列底部安全区
  Widget iphoneBottomWidget(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    print(mq.padding.bottom);
    return Container(
      color: Colors.white,
      height: mq.padding.bottom,
    );
  }
}
