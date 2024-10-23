class ModelParticipants {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? imgUrl;
  int? status;
  bool? isAdmin;

  String? uid;

  ModelParticipants({
    this.email,
    this.password,
    this.phone,
    this.status,
    this.imgUrl,
    this.name,
    this.uid,
    this.isAdmin,
  });

  ModelParticipants.fromJson(Map<String, dynamic> json, idx) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    status = json['status'];
    imgUrl = json['imgUrl'];
    uid = json['uid'];
    isAdmin = json['isAdmin'];
  }

  ModelParticipants.fromMap(Map<String, dynamic> json) {
    email = json["participant"]['email'];
    name = json["participant"]['name'];
    phone = json["participant"]['phone'];
    status = json["participant"]['status'];
    imgUrl = json["participant"]['imgUrl'];
    uid = json["participant"]['_id'];
    isAdmin = json["participant"]['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['status'] = status;
    data['imgUrl'] = imgUrl;
    data['uid'] = uid;
    data['isAdmin'] = isAdmin;

    return data;
  }

  ModelParticipants copyWith({
    String? email,
    String? imgUrl,
    String? phone,
    String? password,
    String? name,
    int? status,
    String? uid,
    bool? isAdmin,
  }) {
    return ModelParticipants(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      imgUrl: imgUrl ?? this.imgUrl,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
