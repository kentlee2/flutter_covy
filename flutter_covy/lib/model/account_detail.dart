/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AccountDetail accountDetailFromJson(String str) =>
    AccountDetail.fromJson(json.decode(str));

String accountDetailToJson(AccountDetail data) => json.encode(data.toJson());

class AccountDetail {
  AccountDetail({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  AccountDetailData data;
  int errorCode;
  String errorMsg;

  factory AccountDetail.fromJson(Map<dynamic, dynamic> json) => AccountDetail(
        data: AccountDetailData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
      };
}

class AccountDetailData {
  AccountDetailData({
    required this.over,
    required this.pageCount,
    required this.total,
    required this.curPage,
    required this.offset,
    required this.size,
    required this.datas,
  });

  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<DataElement> datas;

  factory AccountDetailData.fromJson(Map<dynamic, dynamic> json) =>
      AccountDetailData(
        over: json["over"],
        pageCount: json["pageCount"],
        total: json["total"],
        curPage: json["curPage"],
        offset: json["offset"],
        size: json["size"],
        datas: List<DataElement>.from(
            json["datas"].map((x) => DataElement.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "over": over,
        "pageCount": pageCount,
        "total": total,
        "curPage": curPage,
        "offset": offset,
        "size": size,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
      };
}

class DataElement {
  DataElement({
    required this.shareDate,
    required this.projectLink,
    required this.prefix,
    required this.canEdit,
    required this.origin,
    required this.link,
    required this.title,
    required this.type,
    required this.selfVisible,
    required this.apkLink,
    required this.envelopePic,
    required this.audit,
    required this.chapterId,
    required this.host,
    required this.realSuperChapterId,
    required this.id,
    required this.courseId,
    required this.superChapterName,
    required this.descMd,
    required this.publishTime,
    required this.niceShareDate,
    required this.visible,
    required this.niceDate,
    required this.author,
    required this.zan,
    required this.chapterName,
    required this.userId,
    required this.adminAdd,
    required this.isAdminAdd,
    required this.tags,
    required this.superChapterId,
    required this.fresh,
    required this.collect,
    required this.shareUser,
    required this.desc,
  });

  int? shareDate;
  String projectLink;
  String prefix;
  bool canEdit;
  String origin;
  String link;
  String title;
  int type;
  int selfVisible;
  String apkLink;
  String envelopePic;
  int audit;
  int chapterId;
  String host;
  int realSuperChapterId;
  int id;
  int courseId;
  String superChapterName;
  String descMd;
  int publishTime;
  String niceShareDate;
  int visible;
  String niceDate;
  String author;
  int zan;
  String chapterName;
  int userId;
  bool adminAdd;
  bool isAdminAdd;
  List<Tag> tags;
  int superChapterId;
  bool fresh;
  bool collect;
  String shareUser;
  String desc;

  factory DataElement.fromJson(Map<dynamic, dynamic> json) => DataElement(
        shareDate: json["shareDate"],
        projectLink: json["projectLink"],
        prefix: json["prefix"],
        canEdit: json["canEdit"],
        origin: json["origin"],
        link: json["link"],
        title: json["title"],
        type: json["type"],
        selfVisible: json["selfVisible"],
        apkLink: json["apkLink"],
        envelopePic: json["envelopePic"],
        audit: json["audit"],
        chapterId: json["chapterId"],
        host: json["host"],
        realSuperChapterId: json["realSuperChapterId"],
        id: json["id"],
        courseId: json["courseId"],
        superChapterName: json["superChapterName"],
        descMd: json["descMd"],
        publishTime: json["publishTime"],
        niceShareDate: json["niceShareDate"],
        visible: json["visible"],
        niceDate: json["niceDate"],
        author: json["author"],
        zan: json["zan"],
        chapterName: json["chapterName"],
        userId: json["userId"],
        adminAdd: json["adminAdd"],
        isAdminAdd: json["isAdminAdd"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        superChapterId: json["superChapterId"],
        fresh: json["fresh"],
        collect: json["collect"],
        shareUser: json["shareUser"],
        desc: json["desc"],
      );

  Map<dynamic, dynamic> toJson() => {
        "shareDate": shareDate,
        "projectLink": projectLink,
        "prefix": prefix,
        "canEdit": canEdit,
        "origin": origin,
        "link": link,
        "title": title,
        "type": type,
        "selfVisible": selfVisible,
        "apkLink": apkLink,
        "envelopePic": envelopePic,
        "audit": audit,
        "chapterId": chapterId,
        "host": host,
        "realSuperChapterId": realSuperChapterId,
        "id": id,
        "courseId": courseId,
        "superChapterName": superChapterName,
        "descMd": descMd,
        "publishTime": publishTime,
        "niceShareDate": niceShareDate,
        "visible": visible,
        "niceDate": niceDate,
        "author": author,
        "zan": zan,
        "chapterName": chapterName,
        "userId": userId,
        "adminAdd": adminAdd,
        "isAdminAdd": isAdminAdd,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "superChapterId": superChapterId,
        "fresh": fresh,
        "collect": collect,
        "shareUser": shareUser,
        "desc": desc,
      };
}

class Tag {
  Tag({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Tag.fromJson(Map<dynamic, dynamic> json) => Tag(
        name: json["name"],
        url: json["url"],
      );

  Map<dynamic, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
