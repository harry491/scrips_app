import 'package:my_app/generated/json/base/json_convert_content.dart';
import 'package:my_app/generated/json/base/json_filed.dart';

class MovieEntity with JsonConvert<MovieEntity> {
	String code;
	List<MovieMovie> movies;
	String msg;
}

class MovieMovie with JsonConvert<MovieMovie> {
	@JSONField(name: "ID")
	int iD;
	@JSONField(name: "CreatedAt")
	String createdAt;
	@JSONField(name: "UpdatedAt")
	String updatedAt;
	@JSONField(name: "DeletedAt")
	dynamic deletedAt;
	@JSONField(name: "Title")
	String title;
	@JSONField(name: "Other")
	String other;
	@JSONField(name: "Href")
	String href;
	@JSONField(name: "Head")
	String head;
}
