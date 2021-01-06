class FormulaListModel {
  int categoryId;
  int num;
  int status;
  String name;

  FormulaListModel({this.categoryId, this.num, this.status, this.name});

  FormulaListModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    num = json['num'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['num'] = this.num;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
