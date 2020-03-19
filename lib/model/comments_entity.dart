import 'package:my_app/generated/json/base/json_convert_content.dart';
import 'package:my_app/generated/json/base/json_filed.dart';

class CommentsEntity with JsonConvert<CommentsEntity> {
	String code;
	List<CommantsCommants> comments;
	String msg;
}

class CommantsCommants with JsonConvert<CommantsCommants> {
	@JSONField(name: "ID")
	int iD;
	@JSONField(name: "CreatedAt")
	String createdAt;
	@JSONField(name: "UpdatedAt")
	String updatedAt;
	@JSONField(name: "DeletedAt")
	dynamic deletedAt;
	@JSONField(name: "UserId")
	int userId;
	@JSONField(name: "Alias")
	String alias;
	@JSONField(name: "Head")
	String head;
	@JSONField(name: "Sex")
	int sex;
	@JSONField(name: "ScripId")
	int scripId;
	@JSONField(name: "Content")
	String content;
	@JSONField(name: "PointNumber")
	int pointNumber;
	@JSONField(name: "IsPoint")
	bool isPoint;
}
