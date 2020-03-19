class ScripModelEntity {
  String msg;
  String code;
  List<ScripModelScrip> scrips;

  ScripModelEntity({this.msg, this.code, this.scrips});

  ScripModelEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['scrips'] != null) {
      scrips = new List<ScripModelScrip>();
      (json['scrips'] as List).forEach((v) {
        scrips.add(new ScripModelScrip.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.scrips != null) {
      data['scrips'] = this.scrips.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScripModelScrip {
  List images = [];
  String head;
  String createdAt;
  int sex;
  int pointNumber;
  String updatedAt;
  int userId;
  String content;
  String alias;
  bool isPoint;
  bool isCollect;
  int iD;
  int tag;
  dynamic deletedAt;
  int collectNumber;

  ScripModelScrip(
      {this.head,
      this.createdAt,
      this.sex,
      this.pointNumber,
      this.updatedAt,
      this.userId,
      this.content,
      this.alias,
      this.isPoint,
      this.isCollect,
      this.iD,
      this.tag,
      this.deletedAt,
      this.collectNumber});

  ScripModelScrip.fromJson(Map<String, dynamic> json) {
    head = json['Head'];
    createdAt = json['CreatedAt'];
    sex = json['Sex'];
    pointNumber = json['PointNumber'];
    updatedAt = json['UpdatedAt'];
    userId = json['UserId'];
    content = json['Content'];
    alias = json['Alias'];
    isPoint = json['IsPoint'];
    isCollect = json['IsCollect'];
    iD = json['ID'];
    tag = json['Tag'];
    deletedAt = json['DeletedAt'];
    collectNumber = json['CollectNumber'];
    String Images = json["Images"];
    images = (Images == "" || Images == null) ? [] : Images.split(",");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Head'] = this.head;
    data['CreatedAt'] = this.createdAt;
    data['Sex'] = this.sex;
    data['PointNumber'] = this.pointNumber;
    data['UpdatedAt'] = this.updatedAt;
    data['UserId'] = this.userId;
    data['Content'] = this.content;
    data['Alias'] = this.alias;
    data['IsPoint'] = this.isPoint;
    data['IsCollect'] = this.isCollect;
    data['ID'] = this.iD;
    data['Tag'] = this.tag;
    data['DeletedAt'] = this.deletedAt;
    data['CollectNumber'] = this.collectNumber;
    return data;
  }
}
