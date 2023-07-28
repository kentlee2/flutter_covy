/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

BannerEntity bannerEntityFromJson(String str) => BannerEntity.fromJson(json.decode(str));

String bannerEntityToJson(BannerEntity data) => json.encode(data.toJson());

class BannerEntity {
    BannerEntity({
        required this.data,
        required this.errorCode,
        required this.errorMsg,
    });

    List<BannerListEntity> data;
    int errorCode;
    String errorMsg;

    factory BannerEntity.fromJson(Map<dynamic, dynamic> json) => BannerEntity(
        data: List<BannerListEntity>.from(json["data"].map((x) => BannerListEntity.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class BannerListEntity {
    BannerListEntity({
        required this.imagePath,
        required this.id,
        required this.isVisible,
        required this.title,
        required this.type,
        required this.url,
        required this.desc,
        required this.order,
    });

    String imagePath;
    int id;
    int isVisible;
    String title;
    int type;
    String url;
    String desc;
    int order;

    factory BannerListEntity.fromJson(Map<dynamic, dynamic> json) => BannerListEntity(
        imagePath: json["imagePath"],
        id: json["id"],
        isVisible: json["isVisible"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
        desc: json["desc"],
        order: json["order"],
    );

    Map<dynamic, dynamic> toJson() => {
        "imagePath": imagePath,
        "id": id,
        "isVisible": isVisible,
        "title": title,
        "type": type,
        "url": url,
        "desc": desc,
        "order": order,
    };
}
