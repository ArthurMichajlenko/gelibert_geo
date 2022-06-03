import 'dart:convert';

class GeoData {
  final int _id;
  final String _macAddress;
  final String _courierId;
  final double _latitude;
  final double _longitude;
  final DateTime? _timestamp;

  GeoData(
    int id,
    String macAddress,
    String courierId,
    double latitude,
    double longitude,
    DateTime? timestamp,
  )   : _id = id,
        _macAddress = macAddress,
        _courierId = courierId,
        _latitude = latitude,
        _longitude = longitude,
        _timestamp = (timestamp != null) ? timestamp : DateTime.now();

  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get timestamp => (_timestamp != null) ? _timestamp as DateTime : DateTime.now();

  GeoData copyWith({
    int? id,
    String? macAddress,
    String? courierId,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
  }) {
    return GeoData(
      id ?? _id,
      macAddress ?? _macAddress,
      courierId ?? _courierId,
      latitude ?? _latitude,
      longitude ?? _longitude,
      timestamp ?? _timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'mac_address': _macAddress,
      'courier_id': _courierId,
      'latitude': _latitude,
      'longitude': _longitude,
      'timestamp': _timestamp,
    };
  }

  factory GeoData.fromMap(Map<String, dynamic> map) {
    return GeoData(
      map['id']?.toInt() ?? 0,
      map['mac_address']?._macAddress ?? '',
      map['courier_id']?._courierId ?? '',
      map['latitude']?.toDouble() ?? 0.0,
      map['longitude']?.toDouble() ?? 0.0,
      DateTime.parse(map['timestamp']),
    );
  }

  factory GeoData.fromJson(String source) => GeoData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'GeoData(_id: $_id, _macAddress: $_macAddress, _courierId: $_courierId, _latitude: $_latitude, _longitude: $_longitude, _timestamp: $_timestamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeoData &&
        other._id == _id &&
        other._macAddress == _macAddress &&
        other._courierId == _courierId &&
        other._latitude == _latitude &&
        other._longitude == _longitude &&
        other._timestamp == _timestamp;
  }

  @override
  int get hashCode =>
      _id.hashCode ^
      _macAddress.hashCode ^
      _courierId.hashCode ^
      _latitude.hashCode ^
      _longitude.hashCode ^
      _timestamp.hashCode;
}

List<GeoData> geodataFromJSON(String str) => List<GeoData>.from(json.decode(str).map((x) => GeoData.fromMap(x)));

String geodataToJSON(List<GeoData> data) => json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
