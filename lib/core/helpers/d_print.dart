import 'dart:developer';

import 'package:flutter/foundation.dart';

void dPrint(String message) {
  if (kDebugMode) {
    log(message);
  }
}
