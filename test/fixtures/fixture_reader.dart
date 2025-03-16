import 'dart:convert';
import 'dart:io';

String fixtureString(String name) =>
    File('test/fixtures/$name').readAsStringSync();

Map<String, dynamic> fixtureMap(String name) {
  final content = File('test/fixtures/$name').readAsStringSync();
  return jsonDecode(content) as Map<String, dynamic>;
}

List<dynamic> fixtureList(String name) {
  final content = File('test/fixtures/$name').readAsStringSync();
  return jsonDecode(content) as List<dynamic>;
}
