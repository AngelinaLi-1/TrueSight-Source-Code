import 'package:flutter/foundation.dart';

void safePrint(Object? o) {
  if (kDebugMode) {
    // print(o);
    final pattern = RegExp('.{1,1000}');
    // ignore: avoid_print
    pattern.allMatches(o.toString()).forEach((match) => print(match.group(0)));
  }
}
