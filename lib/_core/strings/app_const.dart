import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Default scroll physics for scrollable widgets
const kScrollPhysics = AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());

const _kPatchNo = 0;
const kVersion = 'v1.0.0${_kPatchNo == 0 ? '' : '-p$_kPatchNo'}';

const kAppName = 'Linkify';

String kError([String? errorOn]) {
  String err = 'Something went wrong';
  if (kDebugMode) err += ' [$errorOn]';
  return err;
}
