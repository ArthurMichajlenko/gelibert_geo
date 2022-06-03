import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gelibert_geo/models/courier.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

final couriersProvider = FutureProvider<List<Courier>>((ref) async {
  final api = Api();
  final content = await http.get(Uri.parse('http://${api.serverURL}:${api.serverPort}/data/all_couriers'), headers: {
    HttpHeaders.authorizationHeader: "Bearer ${api.token}",
  });
  return couriersFromJSON(content.body);
});
