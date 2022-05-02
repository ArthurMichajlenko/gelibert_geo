import 'dart:convert';

class Courier {
  final String _id;
  final String _macAddress;
  final String _tel;
  final String _name;
  final String _carNumber;
  final DateTime _timestamp;

  Courier(
    String id,
    String macAddress,
    String tel,
    String name,
    String carNumber,
    DateTime? timestamp,
  )   : _id = id,
        _macAddress = macAddress,
        _tel = tel,
        _name = name,
        _carNumber = carNumber,
        _timestamp = (timestamp != null) ? timestamp : DateTime.now();

  String get macAddress => _macAddress;
  String get name => _name;
  String get carNumber => _carNumber;

  Courier copyWith({
    String? id,
    String? macAddress,
    String? tel,
    String? name,
    String? carNumber,
    DateTime? timestamp,
  }) {
    return Courier(
      id ?? _id,
      macAddress ?? _macAddress,
      tel ?? _tel,
      name ?? _name,
      carNumber ?? _carNumber,
      timestamp ?? _timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      '_mac_address': _macAddress,
      '_tel': _tel,
      '_name': _name,
      '_carNumber': _carNumber,
      '_timestamp': _timestamp,
    };
  }

  factory Courier.fromMap(Map<String, dynamic> map) {
    return Courier(
      map['_id'] ?? '',
      map['_mac_address'] ?? '',
      map['_tel'] ?? '',
      map['_name'] ?? '',
      map['_carNumber'] ?? '',
      DateTime.parse(map['_timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Courier.fromJson(String source) => Courier.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Courier(_id: $_id, _mac_address: $_macAddress, _tel: $_tel, _name: $_name, _carNumber: $_carNumber, _timestamp: $_timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Courier &&
        other._id == _id &&
        other._macAddress == _macAddress &&
        other._tel == _tel &&
        other._name == _name &&
        other._carNumber == _carNumber &&
        other._timestamp == _timestamp;
  }

  @override
  int get hashCode {
    return _id.hashCode ^ _macAddress.hashCode ^ _tel.hashCode ^ _name.hashCode ^ _carNumber.hashCode ^ _timestamp.hashCode;
  }
}

List<Courier> couriersFromJSON(String str) => List<Courier>.from(json.decode(str).map((x) => Courier.fromJson(x)));

String couriersToJSON(List<Courier> data) => json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
