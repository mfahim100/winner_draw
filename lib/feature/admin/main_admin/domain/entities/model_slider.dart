class ModelSlider {
  String? id;
  String? title;
  String? imgUrl;

  ModelSlider({
    this.id,
    this.title,
    this.imgUrl,
  });

  ModelSlider.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imgUrl'] = imgUrl;

    return data;
  }

  ModelSlider copyWith({
    String? imgUrl,
    String? id,
    String? title,
  }) {
    return ModelSlider(
      id: id ?? this.id,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
