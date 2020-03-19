class UserModelEntity {
	String msg;
	String code;
	UserModelUser user;

	UserModelEntity({this.msg, this.code, this.user});

	UserModelEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		user = json['user'] != null ? new UserModelUser.fromJson(json['user']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		return data;
	}
}

class UserModelUser {
	String head;
	String email;
	String alias;
	String createdAt;
	int sex;
	String token;
	int iD;
	dynamic deletedAt;
	String updatedAt;
	String password;
	String area;

	UserModelUser({this.head, this.email, this.alias, this.createdAt, this.sex, this.token, this.iD, this.deletedAt, this.updatedAt, this.password});

	UserModelUser.fromJson(Map<String, dynamic> json) {
		head = json['Head'];
		email = json['Email'];
		alias = json['Alias'];
		createdAt = json['CreatedAt'];
		sex = json['Sex'];
		token = json['Token'];
		iD = json['ID'];
		deletedAt = json['DeletedAt'];
		updatedAt = json['UpdatedAt'];
		password = json['Password'];
		area = json["Area"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Head'] = this.head;
		data['Email'] = this.email;
		data['Alias'] = this.alias;
		data['CreatedAt'] = this.createdAt;
		data['Sex'] = this.sex;
		data['Token'] = this.token;
		data['ID'] = this.iD;
		data['DeletedAt'] = this.deletedAt;
		data['UpdatedAt'] = this.updatedAt;
		data['Password'] = this.password;
		data['Area'] = this.area;
		return data;
	}
}
