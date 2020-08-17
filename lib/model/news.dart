import 'package:equatable/equatable.dart';

class News extends Equatable {
  final Source source;
  final String title;
  final String description;
  final String urlToImage;
  final String author;
  final String url;
  final String publishedAt;
  final String content;

  News({
    this.source,
    this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.author,
    this.content,
    this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: json["source"] != null ? Source.fromJson(json["source"]) : null,
      title: json["title"],
      description: json["description"],
      urlToImage: json["urlToImage"],
      url: json["url"],
      author: json["author"],
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }
  @override
  List<Object> get props => [source, title, description, urlToImage];
}

class Source extends Equatable {
  final String id;
  final String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json["id"], name: json["name"]);
  }

  Source copyWith(String id, String name) {
    return Source(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object> get props => [id, name];
}
