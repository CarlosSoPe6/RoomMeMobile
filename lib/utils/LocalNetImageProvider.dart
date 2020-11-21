import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider LocalNetImageProvider(String uri) {
  if (uri.startsWith('http')) {
    return NetworkImage(uri);
  }
  return FileImage(
    new File(uri),
  );
}
