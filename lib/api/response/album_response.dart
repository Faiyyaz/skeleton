// To parse this JSON data, do
//
//     final albumResponse = albumResponseFromJson(jsonString);

import 'dart:convert';

List<AlbumResponse> albumResponseFromJson(String str) =>
    List<AlbumResponse>.from(
        json.decode(str).map((x) => AlbumResponse.fromJson(x)));

String albumResponseToJson(List<AlbumResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumResponse {
  AlbumResponse({
    this.userId,
    this.id,
    this.title,
  });

  int? userId;
  int? id;
  String? title;

  factory AlbumResponse.fromJson(Map<String, dynamic> json) => AlbumResponse(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
