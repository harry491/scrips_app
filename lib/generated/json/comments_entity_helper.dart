import 'package:my_app/model/comments_entity.dart';

commentsEntityFromJson(CommentsEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['comments'] != null) {
		data.comments = new List<CommantsCommants>();
		(json['comments'] as List).forEach((v) {
			data.comments.add(new CommantsCommants().fromJson(v));
		});
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> commentsEntityToJson(CommentsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.comments != null) {
		data['comments'] =  entity.comments.map((v) => v.toJson()).toList();
	}
	data['msg'] = entity.msg;
	return data;
}

commantsCommantsFromJson(CommantsCommants data, Map<String, dynamic> json) {
	if (json['ID'] != null) {
		data.iD = json['ID']?.toInt();
	}
	if (json['CreatedAt'] != null) {
		data.createdAt = json['CreatedAt']?.toString();
	}
	if (json['UpdatedAt'] != null) {
		data.updatedAt = json['UpdatedAt']?.toString();
	}
	if (json['DeletedAt'] != null) {
		data.deletedAt = json['DeletedAt'];
	}
	if (json['UserId'] != null) {
		data.userId = json['UserId']?.toInt();
	}
	if (json['Alias'] != null) {
		data.alias = json['Alias']?.toString();
	}
	if (json['Head'] != null) {
		data.head = json['Head']?.toString();
	}
	if (json['Sex'] != null) {
		data.sex = json['Sex']?.toInt();
	}
	if (json['ScripId'] != null) {
		data.scripId = json['ScripId']?.toInt();
	}
	if (json['Content'] != null) {
		data.content = json['Content']?.toString();
	}
	if (json['PointNumber'] != null) {
		data.pointNumber = json['PointNumber']?.toInt();
	}
	if (json['IsPoint'] != null) {
		data.isPoint = json['IsPoint'];
	}
	return data;
}

Map<String, dynamic> commantsCommantsToJson(CommantsCommants entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ID'] = entity.iD;
	data['CreatedAt'] = entity.createdAt;
	data['UpdatedAt'] = entity.updatedAt;
	data['DeletedAt'] = entity.deletedAt;
	data['UserId'] = entity.userId;
	data['Alias'] = entity.alias;
	data['Head'] = entity.head;
	data['Sex'] = entity.sex;
	data['ScripId'] = entity.scripId;
	data['Content'] = entity.content;
	data['PointNumber'] = entity.pointNumber;
	data['IsPoint'] = entity.isPoint;
	return data;
}