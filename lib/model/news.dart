import 'dart:convert';

import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String id;
  final String title;
  final String description;
  final String url;
  final String author;
  final String image;
  final String language;
  final List<String> category;
  final String published;

  News({
    this.id,
    this.title,
    this.description,
    this.image,
    this.url,
    this.author,
    this.language,
    this.category,
    this.published,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      url: json["url"],
      category: List<String>.from(json["category"] as List),
      language: json["language"],
      author: json["author"],
      published: json["published"],
    );
  }
  @override
  List<Object> get props => [id, title, description, image];
}
