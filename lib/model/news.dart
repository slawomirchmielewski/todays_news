import 'package:equatable/equatable.dart';

///
/// News model
///
class News extends Equatable {
  /// News Id
  final String id;

  /// News title
  final String title;

  /// News description
  final String description;

  /// Url to news website
  final String url;

  /// Author of the article
  final String author;

  /// Cover image for the news
  final String image;

  /// The language the new is in
  final String language;

  /// Categories the news is in
  final List<String> category;

  /// Date and time the news was published
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
      id: json["id"] != null ? json["id"] : "",
      title: json["title"] != null ? json["title"] : "",
      description: json["description"] != null ? json["description"] : "",
      image: json["image"],
      url: json["url"],
      category: json["category"] != null
          ? List<String>.from(json["category"] as List)
          : [],
      language: json["language"] != null ? json["language"] : "",
      author: json["author"] != null ? json["author"] : "",
      published: json["published"] != null ? json["published"] : "",
    );
  }
  @override
  List<Object> get props => [id, title, description, image];
}
