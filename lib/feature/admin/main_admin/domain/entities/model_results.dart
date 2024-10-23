import 'package:intl/intl.dart';

class ModelResults {
  String? pid;
  String? title;
  int? price;
  String? description;
  int? timer;
  String? imgUrl;
  int? status;
  int? prizeNo;
  String? uid;

  String? name;
  String? email;
  String? phone;
  String? userImg;

  ModelResults({
    this.pid,
    this.price,
    this.description,
    this.timer,
    this.status,
    this.imgUrl,
    this.title,
    this.uid,
    this.prizeNo,
    this.name,
    this.email,
    this.phone,
    this.userImg,
  });

  ModelResults.fromMap(Map<String, dynamic> json) {

    print(json['_id']);
    print(json['draw']['drawNumber']);
    print(json['draw']['price']);
    print(json['draw']['title']);
    print(json['draw']['openAt']);
    print(json['draw']['status']);
    // print();
    // print();
    // print();
    // print();
    // print();

    pid = json['_id'];
    prizeNo = json['draw']['drawNumber'] == "First"
        ? 1
        : json['draw']['drawNumber'] == "Second"
            ? 2
            : 3;
    price = int.parse(json['draw']['price']);
    title = json['draw']['title'];
    DateTime dateValue;
    try{
       dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
          .parseUTC(json['draw']['openAt'])
          .toLocal();
    }catch(e){
       dateValue = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parseUTC(json['draw']['openAt'])
          .toLocal();
    }


    timer = DateTime(dateValue.year, dateValue.month, dateValue.day,
            dateValue.hour, dateValue.month)
        .millisecondsSinceEpoch;
    status = json['draw']['status'] == "active" ? 0 : 1;
    imgUrl = json['draw']['imgUrl'];
    uid = json['winner']["_id"];
    description = json['description'] ?? "";
    email = json["winner"]['email'] ?? "";
    name = json["winner"]['name'] ?? "";
    phone = json["winner"]['phone'] ?? "";
    userImg = json["winner"]['profilePic'] ?? "";
    print("::::::::::: ${json["winner"]['name']} : $name");
    print("::::::::::: ${json["winner"]['phone']} : $phone");
    print("::::::::::: ${json['draw']['drawNumber']} : $prizeNo");
    if (json["winner"]['phone'] == null) {
      phone = "03000136706";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['prizeNo'] = prizeNo;
    data['uid'] = uid;
    data['imgUrl'] = imgUrl;
    data['title'] = title;
    data['price'] = price;
    data['timer'] = timer;
    data['status'] = status;
    data['description'] = description;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['userImg'] = userImg;

    return data;
  }

  ModelResults copyWith({
    int? price,
    String? imgUrl,
    int? timer,
    String? description,
    String? title,
    String? pid,
    int? status,
    int? prizeNo,
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? userImg,
  }) {
    return ModelResults(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      timer: timer ?? this.timer,
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
      prizeNo: prizeNo ?? this.prizeNo,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userImg: userImg ?? this.userImg,
    );
  }
}
