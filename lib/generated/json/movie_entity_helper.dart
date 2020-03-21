import 'package:my_app/model/movie_entity.dart';

movieEntityFromJson(MovieEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['movies'] != null) {
		data.movies = new List<MovieMovie>();
		(json['movies'] as List).forEach((v) {
			data.movies.add(new MovieMovie().fromJson(v));
		});
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> movieEntityToJson(MovieEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.movies != null) {
		data['movies'] =  entity.movies.map((v) => v.toJson()).toList();
	}
	data['msg'] = entity.msg;
	return data;
}

movieMovieFromJson(MovieMovie data, Map<String, dynamic> json) {
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
	if (json['Title'] != null) {
		data.title = json['Title']?.toString();
	}
	if (json['Other'] != null) {
		data.other = json['Other']?.toString();
	}
	if (json['Href'] != null) {
		data.href = json['Href']?.toString();
	}
	if (json['Head'] != null) {
		data.head = json['Head']?.toString();
	}
	return data;
}

Map<String, dynamic> movieMovieToJson(MovieMovie entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ID'] = entity.iD;
	data['CreatedAt'] = entity.createdAt;
	data['UpdatedAt'] = entity.updatedAt;
	data['DeletedAt'] = entity.deletedAt;
	data['Title'] = entity.title;
	data['Other'] = entity.other;
	data['Href'] = entity.href;
	data['Head'] = entity.head;
	return data;
}