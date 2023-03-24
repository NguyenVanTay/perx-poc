class Customer {
  String? id;
  String? identifier;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? email;
  String? birthday;
  String? gender;
  PersonalProperties? personalProperties;
  String? state;
  DateTime? joinedAt;
  DateTime? passwordExpiresAt;

  Customer(
      {this.id,
      this.identifier,
      this.firstName,
      this.middleName,
      this.lastName,
      this.phone,
      this.email,
      this.birthday,
      this.gender,
      this.personalProperties,
      this.state,
      this.joinedAt,
      this.passwordExpiresAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identifier = json['identifier'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    birthday = json['birthday'];
    gender = json['gender'];
    personalProperties = json['personal_properties'] != null
        ? PersonalProperties.fromJson(json['personal_properties'])
        : null;
    state = json['state'];
    joinedAt = json['joined_at'];
    passwordExpiresAt = json['password_expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['identifier'] = identifier;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['birthday'] = birthday;
    data['gender'] = gender;
    if (personalProperties != null) {
      data['personal_properties'] = personalProperties!.toJson();
    }
    data['state'] = state;
    data['joined_at'] = joinedAt;
    data['password_expires_at'] = passwordExpiresAt;
    return data;
  }
}

class PersonalProperties {
  String? email;
  String? phone;
  String? gender;
  String? address;
  String? birthday;
  String? nickname;
  DateTime? joinedAt;

  PersonalProperties(
      {this.email,
      this.phone,
      this.gender,
      this.address,
      this.birthday,
      this.nickname,
      this.joinedAt});

  PersonalProperties.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    address = json['address'];
    birthday = json['birthday'];
    nickname = json['nickname'];
    joinedAt = json['joined_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['address'] = address;
    data['birthday'] = birthday;
    data['nickname'] = nickname;
    data['joined_at'] = joinedAt;
    return data;
  }
}
