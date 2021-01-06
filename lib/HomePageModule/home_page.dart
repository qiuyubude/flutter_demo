import 'package:demo/Formula/Views/Models/formula_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Formula/Views/formula_second_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _jumpToFormulaSecondList() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      FormulaListModel listmodel = FormulaListModel();
      listmodel.categoryId = 4;
      listmodel.name = "急重症医学";
      listmodel.num = 149;
      return FormulaSecondList(listModel: listmodel);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.blue,
          onPressed: _jumpToFormulaSecondList,
          child: Text('跳转医学公式二季页面'),
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
}
