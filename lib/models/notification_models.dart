// To parse this JSON data, do
//
//     final Notifications = NotificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
      json.decode(str).map(
            (x) => Notifications.fromJson(x),
          ),
    );

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  Notifications({
    this.id,
    this.title,
    this.userId,
    this.content,
    this.image,
    this.dateCreated,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  dynamic userId;
  String content;
  String image;
  DateTime dateCreated;
  dynamic createdAt;
  dynamic updatedAt;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        title: json["title"],
        userId: json["userID"],
        content: json["content"],
        image: json["image"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userID": userId,
        "content": content,
        "image": image,
        "dateCreated": dateCreated.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
