class ModelPhotoComments {

  String? id;
  String? pid;
  String? comment;
  int? status;
  int? millis;
  String? uid;

  ModelPhotoComments({
    this.id,
this.comment,
    this.status,
    this.pid,
    this.millis,
    this.uid,
  });


  ModelPhotoComments.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    millis = json['millis']??0;
    comment = json['text'];

    status = json['status']??0;
    pid = json['post'];
    uid = json['user']["_id"]??"";

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['millis'] = millis;
    data['comment'] = comment;
    data['uid'] = uid;
    data['pid'] = pid;
    data['status'] = status;

    return data;
  }

  Map<String, dynamic> toJsonApi() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = comment;
    data['user'] = uid;
    data['post'] = pid;

    return data;
  }

  ModelPhotoComments copyWith({
    String? pid,
    String? comment,
    int? millis,
    String? id,
    int? status,
    int? like,
    String? uid,
  }) {
    return ModelPhotoComments(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      pid: pid ?? this.pid,
      comment: comment ?? this.comment,
      millis: millis ?? this.millis,
      status: status ?? this.status,
    );
  }
}
