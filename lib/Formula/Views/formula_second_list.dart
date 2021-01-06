import 'package:demo/Formula/Views/Models/formula_list_model.dart';
import 'package:demo/Formula/Views/Models/formula_second_list_model.dart';
import 'package:flutter/material.dart';
import 'package:doctor_site/api.dart';
import 'package:azlistview/azlistview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:lpinyin/lpinyin.dart';

class FormulaSecondList extends StatefulWidget {
  final FormulaListModel listModel;
  FormulaSecondList({Key key, this.listModel});

  @override
  _FormulaSecondListState createState() => _FormulaSecondListState();
}

class _FormulaSecondListState extends State<FormulaSecondList> {
  List<FormulaSecondListModel> dataList = [];
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
        String pinyin = PinyinHelper.getPinyinE(model.pinYin);
        String tag = pinyin.substring(0, 1).toUpperCase();
        model.pinYin = pinyin;
        if (RegExp("[A-Z]").hasMatch(tag)) {
          model.pinYin = tag;
        } else {
          model.pinYin = "#";
        }
        mList.add(model);
      }
      // A-Z sort.
      SuspensionUtil.sortListBySuspensionTag(mList);

      // show sus tag.
      SuspensionUtil.setShowSuspensionStatus(mList);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listModel.name,
          style: TextStyle(color: Colors.black),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: AzListView(
        data: dataList,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          FormulaSecondListModel model = dataList[index];
          return getListItem(context, model);
        },
        itemScrollController: itemScrollController,
        susItemBuilder: (BuildContext context, int index) {
          FormulaSecondListModel model = dataList[index];
          return getSusItem(context, model.getSuspensionTag());
        },
        indexBarOptions: IndexBarOptions(
          needRebuild: true,
          selectTextStyle: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          selectItemDecoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFF333333)),
          indexHintWidth: 96,
          indexHintHeight: 97,
          indexHintDecoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/images/Home/ic_index_bar_bubble_gray.png'),
              fit: BoxFit.contain,
            ),
          ),
          indexHintAlignment: Alignment.centerRight,
          indexHintTextStyle: TextStyle(fontSize: 24.0, color: Colors.black87),
          indexHintOffset: Offset(-30, 0),
        ),
      ),
    );
  }

  ///构建悬停Widget.
  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: true,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget getListItem(BuildContext context, FormulaSecondListModel model,
      {double susHeight = 40}) {
    return ListTile(
      title: Text(model.name),
      onTap: () {
        // LogUtil.v("onItemClick : $model");
        // Utils.showSnackBar(context, "onItemClick : $model");
      },
    );
  }

  // 直播间标题
  Widget studioTitleWidget(String studioTitle) {
    // EdgeInsets edg = EdgeInsets.fromLTRB(6, 10, 15, 0);
    return Expanded(
        child: Container(
      // padding: edg,
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
}
