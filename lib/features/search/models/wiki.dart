// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:wiki_freo/features/search/models/wiki_page.dart';

class Wiki {
  List<WikiPage> nodes;
  num offset;
  bool hasNext;
  Wiki({
    required this.nodes,
    required this.offset,
    required this.hasNext,
  });

  Wiki copyWith({
    List<WikiPage>? nodes,
    num? offset,
    bool? hasNext,
  }) {
    return Wiki(
      nodes: nodes ?? this.nodes,
      offset: offset ?? this.offset,
      hasNext: hasNext ?? this.hasNext,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nodes': nodes.map((x) => x.toMap()).toList(),
      'offset': offset,
      'hasNext': hasNext,
    };
  }

  factory Wiki.fromMap(Map<String, dynamic> map) {
    return Wiki(
      nodes: map['query'] != null
          ? (map['query']['pages'] as Map<String, dynamic>)
              .entries
              .map((e) => WikiPage.fromMap(e.value))
              .toList()
          : [],
      offset: map['continue'] != null && map['continue']['gpsoffset'] != null
          ? map['continue']['gpsoffset'] as num
          : 0,
      hasNext: map['continue'] != null && map['continue']['gpsoffset'] != null
          ? true
          : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wiki.fromJson(String source) =>
      Wiki.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Wiki(nodes: $nodes, offset: $offset, hasNext: $hasNext)';

  @override
  bool operator ==(covariant Wiki other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.nodes, nodes) &&
        other.offset == offset &&
        other.hasNext == hasNext;
  }

  @override
  int get hashCode => nodes.hashCode ^ offset.hashCode ^ hasNext.hashCode;
}
