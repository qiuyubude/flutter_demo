import 'dart:convert';

Allstudiolistmodel allstudiolistmodelFromJson(String str) =>
    Allstudiolistmodel.fromJson(json.decode(str));

String allstudiolistmodelToJson(Allstudiolistmodel data) =>
    json.encode(data.toJson());

class Allstudiolistmodel {
  Allstudiolistmodel({
    this.studioId,
    this.studioImg,
    this.fansNum,
    this.living,
    this.subjectNum,
    this.studioIntro,
    this.hots,
    this.isFans,
    this.studioTitle,
  });

  int studioId;
  String studioImg;
  int fansNum;
  int living;
  int subjectNum;
  String studioIntro;
  int hots;
  bool isFans;
  String studioTitle;

  factory Allstudiolistmodel.fromJson(Map<String, dynamic> json) =>
      Allstudiolistmodel(
        studioId: json["studioId"],
        studioImg: json["studioImg"],
        fansNum: json["fansNum"],
        living: json["living"],
        subjectNum: json["subjectNum"],
        studioIntro: json["studioIntro"],
        hots: json["hots"],
        isFans: json["isFans"],
        studioTitle: json["studioTitle"],
      );

  Map<String, dynamic> toJson() => {
        "studioId": studioId,
        "studioImg": studioImg,
        "fansNum": fansNum,
        "living": living,
        "subjectNum": subjectNum,
        "studioIntro": studioIntro,
        "hots": hots,
        "isFans": isFans,
        "studioTitle": studioTitle,
      };
}
