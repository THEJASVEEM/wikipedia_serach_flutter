// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WikiPage {
  num pageId;
  num index;
  String title;
  String? thumbnail;
  String? description;
  WikiPage({
    required this.pageId,
    required this.index,
    required this.title,
    this.thumbnail,
    this.description,
  });

  WikiPage copyWith({
    num? pageId,
    num? index,
    String? title,
    String? thumbnail,
    String? description,
  }) {
    return WikiPage(
      pageId: pageId ?? this.pageId,
      index: index ?? this.index,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageId': pageId,
      'index': index,
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
    };
  }

  factory WikiPage.fromMap(Map<String, dynamic> map) {
    return WikiPage(
      pageId: map['pageid'] as num,
      index: map['index'] as num,
      title: map['title'] as String,
      thumbnail: map['thumbnail'] != null && map['thumbnail']['source'] != null
          ? map['thumbnail']['source'] as String
          : null,
      description: map['terms'] != null &&
              (map['terms']['description'] as List).isNotEmpty
          ? map['terms']['description'][0] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WikiPage.fromJson(String source) =>
      WikiPage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WikiPage(pageId: $pageId, index: $index, title: $title, thumbnail: $thumbnail, description: $description)';
  }

  @override
  bool operator ==(covariant WikiPage other) {
    if (identical(this, other)) return true;

    return other.pageId == pageId &&
        other.index == index &&
        other.title == title &&
        other.thumbnail == thumbnail &&
        other.description == description;
  }

  @override
  int get hashCode {
    return pageId.hashCode ^
        index.hashCode ^
        title.hashCode ^
        thumbnail.hashCode ^
        description.hashCode;
  }
}
