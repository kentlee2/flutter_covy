/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

PublicAccount publicAccountFromJson(String str) => PublicAccount.fromJson(json.decode(str));

String publicAccountToJson(PublicAccount data) => json.encode(data.toJson());

class PublicAccount {
    PublicAccount({
        required this.data,
        required this.errorCode,
        required this.errorMsg,
    });

    List<Datum> data;
    int errorCode;
    String errorMsg;

    factory PublicAccount.fromJson(Map<dynamic, dynamic> json) => PublicAccount(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class Datum {
    Datum({
        required this.lisense,
        required this.visible,
        required this.author,
        required this.lisenseLink,
        required this.type,
        required this.parentChapterId,
        required this.cover,
        required this.articleList,
        required this.children,
        required this.name,
        required this.userControlSetTop,
        required this.id,
        required this.courseId,
        required this.desc,
        required this.order,
    });

    String lisense;
    int visible;
    String author;
    String lisenseLink;
    int type;
    int parentChapterId;
    String cover;
    List<dynamic> articleList;
    List<dynamic> children;
    String name;
    bool userControlSetTop;
    int id;
    int courseId;
    String desc;
    int order;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        lisense: json["lisense"],
        visible: json["visible"],
        author: json["author"],
        lisenseLink: json["lisenseLink"],
        type: json["type"],
        parentChapterId: json["parentChapterId"],
        cover: json["cover"],
        articleList: List<dynamic>.from(json["articleList"].map((x) => x)),
        children: List<dynamic>.from(json["children"].map((x) => x)),
        name: json["name"],
        userControlSetTop: json["userControlSetTop"],
        id: json["id"],
        courseId: json["courseId"],
        desc: json["desc"],
        order: json["order"],
    );

    Map<dynamic, dynamic> toJson() => {
        "lisense": lisense,
        "visible": visible,
        "author": author,
        "lisenseLink": lisenseLink,
        "type": type,
        "parentChapterId": parentChapterId,
        "cover": cover,
        "articleList": List<dynamic>.from(articleList.map((x) => x)),
        "children": List<dynamic>.from(children.map((x) => x)),
        "name": name,
        "userControlSetTop": userControlSetTop,
        "id": id,
        "courseId": courseId,
        "desc": desc,
        "order": order,
    };
}
