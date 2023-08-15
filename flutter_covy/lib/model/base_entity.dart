class BaseEntity {
  BaseEntity({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  List<dynamic>? data;
  int errorCode;
  String errorMsg;

  factory BaseEntity.fromJson(Map<dynamic, dynamic> json) {
    if(json["data"]==null){
      return BaseEntity(data: null, errorCode: json["errorCode"], errorMsg: json["errorMsg"]);
    }
    return BaseEntity(
      data: List<BaseEntity>.from(
          json["data"].map((x) => BaseEntity.fromJson(x))),
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
      };
}
