// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

PostsModel postsModelFromJson(String str) =>  PostsModel.fromJson(json.decode(str));
String postsModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
  String id;
  String title;
  String image;

  PostsModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}
