import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String _serverURL;
  final int _serverPort;
  final String _user;
  late final String token;

  static Api? _instance;

  Api._(
    this._serverURL,
    this._serverPort,
    this._user,
  );

  factory Api({
    serverURL,
    serverPort,
    user,
    token,
  }) {
    _instance ??= Api._(serverURL, serverPort, user);
    return _instance!;
  }
  String get serverURL => _serverURL;
  int get serverPort => _serverPort;

  Future<String> getToken() async {
    String url = 'http://$_serverURL:$_serverPort';
    var res = await http.post(
      Uri.parse('$url/login'),
      body: {'macAddress': _user},
    );
    var tk = jsonDecode(res.body);
    return tk['token'];
  }

  @override
  String toString() => 'Api(serverURL: $_serverURL, serverPort: $_serverPort, user: $_user, token: $token)';
}
