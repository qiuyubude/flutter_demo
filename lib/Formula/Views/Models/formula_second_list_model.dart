import 'package:azlistview/azlistview.dart';

class FormulaSecondListModel extends ISuspensionBean {
  int formulaId;
  String formulaIdName;
  String introduce;
  int isNew;
  String linkUrl;
  String name;
  String origin;
  String pinYin;
  int status;
  String style;

  FormulaSecondListModel(
      {this.formulaId,
      this.formulaIdName,
      this.introduce,
      this.isNew,
      this.linkUrl,
      this.name,
      this.origin,
      this.pinYin,
      this.status,
      this.style});

  FormulaSecondListModel.fromJson(Map<String, dynamic> json) {
    formulaId = json['formulaId'];
    formulaIdName = json['formulaIdName'];
    introduce = json['introduce'];
    isNew = json['isNew'];
    linkUrl = json['linkUrl'];
    name = json['name'];
    origin = json['origin'];
    pinYin = json['pinYin'];
    status = json['status'];
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formulaId'] = this.formulaId;
    data['formulaIdName'] = this.formulaIdName;
    data['introduce'] = this.introduce;
    data['isNew'] = this.isNew;
    data['linkUrl'] = this.linkUrl;
    data['name'] = this.name;
    data['origin'] = this.origin;
    data['pinYin'] = this.pinYin;
    data['status'] = this.status;
    data['style'] = this.style;
    return data;
  }

  @override
  String getSuspensionTag() => pinYin;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
