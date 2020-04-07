import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

var utf8Encoder = Utf8Encoder();
///Generate MD5 hash
String generateMd5(String data) {
  var content = utf8Encoder.convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}