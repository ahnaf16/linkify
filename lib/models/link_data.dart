import 'package:flutter/widgets.dart';
import 'package:linkify/_core/extensions/map_ex.dart';
import 'package:linkify/models/link_editing_state.dart';
import 'package:nanoid2/nanoid2.dart';

class LinkData {
  LinkData({
    required this.id,
    required this.url,
    this.title,
    this.description,
    this.image,
    this.siteName,
    this.tag,
    this.isSynced = false,
    this.isPinned = false,
    required this.createdAt,
    required this.updatedAt,
    this.aiSummary,
  });

  final String id;
  final String url;
  final String? title;
  final String? description;
  final String? image;
  final String? siteName;
  final String? tag;
  final bool isSynced;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? aiSummary;

  factory LinkData.fromState(LinkState state) => LinkData(
    id: nanoid(),
    url: state.url ?? '',
    title: state.title,
    description: state.description,
    image: state.image,
    siteName: state.siteName,
    tag: state.tag,
    isSynced: state.isSynced,
    isPinned: state.isPinned,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  factory LinkData.fromMap(Map<String, dynamic> map) => LinkData(
    id: map['id'] ?? '',
    url: map['url'] ?? '',
    title: map['title'],
    description: map['description'],
    image: map['image'],
    siteName: map['siteName'],
    tag: map['tag'],
    isSynced: map.parseBool('isSynced'),
    isPinned: map.parseBool('isPinned'),
    createdAt: DateTime.parse(map['createdAt']),
    updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    aiSummary: map['aiSummary'],
  );

  Map<String, dynamic> toMap({bool update = false}) => {
    'id': id,
    'url': url,
    'title': title,
    'description': description,
    'image': image,
    'siteName': siteName,
    'tag': tag,
    'isSynced': isSynced,
    'isPinned': isPinned,
    if (!update) 'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'aiSummary': aiSummary,
  };

  LinkData copyWith({
    String? id,
    String? url,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? image,
    ValueGetter<String?>? siteName,
    ValueGetter<String?>? tag,
    bool? isSynced,
    bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
    ValueGetter<String?>? aiSummary,
  }) {
    return LinkData(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      image: image != null ? image() : this.image,
      siteName: siteName != null ? siteName() : this.siteName,
      tag: tag != null ? tag() : this.tag,
      isSynced: isSynced ?? this.isSynced,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      aiSummary: aiSummary != null ? aiSummary() : this.aiSummary,
    );
  }
}
