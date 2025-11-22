import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linkify/models/link_data.dart';

@GenerateAdapters([AdapterSpec<LinkData>()])
part 'hive_db.g.dart';

class HBoxes {
  static const linkBoxName = 'links';
}
