import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/models/category.dart';
import 'package:linkify/models/link_data.dart';
import 'package:linkify/models/tag.dart';

@GenerateAdapters([AdapterSpec<LinkData>(), AdapterSpec<Category>(), AdapterSpec<Tag>()])
part 'hive_db.g.dart';

class HBoxes {
  static const linkBoxName = 'links';
  static const tagBoxName = 'tags';
  static const categoryBoxName = 'categories';
}
