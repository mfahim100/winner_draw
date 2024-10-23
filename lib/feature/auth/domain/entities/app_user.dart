import 'dart:io';

import 'package:dio/dio.dart';

class AppUser {
  // String? id;
  // String? firstName;
  // String? lastName;
  // String? email;
  // String? profilePic;
  // String? province;
  // String? gender;
  // String? role;
  // String? isSocial;
  // String? isVerified;
  // String? isDocsVerified;
  // String? isAdmin;
  // String? createdAt;
  // String? updatedAt;
  String? token;
  // String? password;

  String? name;
  String? province;
  String? email;
  String? password;
  String? contact;
  String? profilePicture;
  int? status;
  bool? isAdmin;
  String? uid;
  File? file;

  AppUser({

    this.name,
    this.province,
    this.email,
    this.password,
    this.contact,
    this.profilePicture,
    this.status,
    this.isAdmin,
    this.uid,
    this.token,
    this.file,
    // this.id,
    // this.firstName,
    // this.lastName,
    // this.email,
    // this.profilePic,
    // this.province,
    // this.gender,
    // this.role,
    // this.isSocial,
    // this.isVerified,
    // this.isDocsVerified,
    // this.isAdmin,
    // this.createdAt,
    // this.updatedAt,
    // this.token,
    // this.password,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['_id']??"";
    // firstName = json['firstName']??"";
    // lastName = json['lastName']??"";
    // email = json['email']??"";
    // profilePic = json['profilePic']??"";
    // province = json['province']??"";
    // gender = json['gender']??"";
    // role = json['role']??"";
    // isSocial = json['isSocial']??"";
    // isVerified = json['isVerified']??"";
    // isDocsVerified = json['isDocsVerified']??"";
    // isAdmin = json['isAdmin']??"";
    // createdAt = json['createdAt']??"";
    // updatedAt = json['updatedAt']??"";
    token = json['token']??"";
    // password = json['password']??"";
    // province = json['province']??"KPK";
    name = json['name'];
    province = json['province'];
    email = json['email'];
    password = json['password'];
    contact = json['contact'];
    profilePicture = json['profilePic'];
    status = json['status'];
    isAdmin = json['isAdmin'];
  }


  // AppUser.fromMap(Map<String, dynamic> json) {
  //
  //   province = json['province']??"KPK";
  //   email = json['email'];
  //   name = json['name'];
  //   phone = json['phone'];
  //   status = json['status'];
  //   imgUrl = json['imgUrl'];
  //   uid = json['uid'];
  //   isAdmin = json['isAdmin'];
  // }

  AppUser.fromMap(Map<String, dynamic> json) {

    province = json['province']??"kpk";
    email = json['email'];
    name = json['name'];
    contact = json['contact'];
    status = json['status'];
    profilePicture = json['profilePicture'];
    uid = json['uid'];
    isAdmin = json['isAdmin'];
    token = json['token'];
    uid = json['_id'];


    print("");
    print("");
    print("");
    print("name : $name");
    print("province : $province");
    print("email : $email");
    print("phone : $contact");
    print("status : $status");
    print("imgUrl : $profilePicture");
    print("uid : $uid");
    print("isAdmin : $isAdmin");
  }

  formData() async {
    FormData formData = FormData.fromMap({
      '_id' : uid,
      'name' : name,
      'profilePicture' : await  MultipartFile.fromFile(file!.path, filename: DateTime.now().millisecondsSinceEpoch.toString()),
      'province' : province,
      'email' : email,
      'password' : password,
      'contact' : contact,
      'token' : token,
    });

    return formData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['province'] = province;
    data['email'] = email;
    data['password'] = password;
    data['contact'] = contact;
    data['profilePicture'] = profilePicture;
    // data['status'] = status;
    // data['isAdmin'] = isAdmin;
    // data['id'] = id;
    data['_id'] = uid;
    // data['firstName'] = firstName;
    // data['lastName'] = lastName;
    // data['email'] = email;
    // data['profilePic'] = profilePic;
    // data['province'] = province;
    // data['gender'] = gender;
    // data['role'] = role;
    // data['isSocial'] = isSocial;
    // data['isVerified'] = isVerified;
    // data['isDocsVerified'] = isDocsVerified;
    // data['isAdmin'] = isAdmin;
    // data['createdAt'] = createdAt;
    // data['updatedAt'] = updatedAt;
    data['token'] = token;
    // data['password'] = password;


    return data;
  }

  AppUser copyWith({

    String? name,
    String? province,
    String? email,
    String? password,
    String? contact,
    String? profilePicture,
    int? status,
    bool? isAdmin,
    String? uid,
    // String? id,
    // String? firstName,
    // String? lastName,
    // String? email,
    // String? profilePic,
    // String? province,
    // String? gender,
    // String? role,
    // String? isSocial,
    // String? isVerified,
    // String? isDocsVerified,
    // String? isAdmin,
    // String? createdAt,
    // String? updatedAt,
    String? token,
    File? file,
    // String? password,
  }) {
    return AppUser(
      name: name ?? this.name,
      province: province ?? this.province,
      email: email ?? this.email,
      password: password ?? this.password,
      contact: contact ?? this.contact,
      profilePicture: profilePicture ?? this.profilePicture,
      status: status ?? this.status,
      isAdmin: isAdmin ?? this.isAdmin,
      uid: uid ?? this.uid,
      // firstName: firstName ?? this.firstName,
      // lastName: lastName ?? this.lastName,
      // email: email ?? this.email,
      // profilePic: profilePic ?? this.profilePic,
      // province: province ?? this.province,
      // gender: gender ?? this.gender,
      // role: role ?? this.role,
      // isSocial: isSocial ?? this.isSocial,
      // isVerified: isVerified ?? this.isVerified,
      // isDocsVerified: isDocsVerified ?? this.isDocsVerified,
      // isAdmin: isAdmin ?? this.isAdmin,
      // createdAt: createdAt ?? this.createdAt,
      // updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
      file: file ?? this.file,
      // password: password ?? this.password,

    );
  }
}

