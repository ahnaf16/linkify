import 'package:flutter/widgets.dart';
import 'package:linkify/models/link_data.dart';

class LinkState {
  const LinkState({
    this.url,
    this.title,
    this.description,
    this.image,
    this.siteName,
    this.tag,
    this.isSynced = false,
    this.isPinned = false,
  });

  final String? url;
  final String? title;
  final String? description;
  final String? image;
  final String? siteName;
  final String? tag;
  final bool isSynced;
  final bool isPinned;

  factory LinkState.fromLinkData(LinkData link) => LinkState(
    url: link.url,
    title: link.title,
    description: link.description,
    image: link.image,
    siteName: link.siteName,
    tag: link.tag,
    isSynced: link.isSynced,
    isPinned: link.isPinned,
  );

  LinkState copyWith({
    ValueGetter<String?>? url,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? image,
    ValueGetter<String?>? siteName,
    ValueGetter<String?>? tag,
    bool? isSynced,
    bool? isPinned,
  }) {
    return LinkState(
      url: url != null ? url() : this.url,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      image: image != null ? image() : this.image,
      siteName: siteName != null ? siteName() : this.siteName,
      tag: tag != null ? tag() : this.tag,
      isSynced: isSynced ?? this.isSynced,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
