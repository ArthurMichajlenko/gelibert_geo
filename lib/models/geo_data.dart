import 'dart:convert';

class GeoData {
  final double _latitude;
  final double _longitude;
  final DateTime? _timestamp;

  GeoData(
    double latitude,
    double longitude,
    DateTime? timestamp,
  )   : _latitude = latitude,
        _longitude = longitude,
        _timestamp = (timestamp != null) ? timestamp : DateTime.now();

  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get timestamp => (_timestamp != null) ? _timestamp as DateTime : DateTime.now();

  GeoData copyWith({
    double? latitude,
    double? longitude,
    DateTime? timestamp,
  }) {
    return GeoData(
      latitude ?? _latitude,
      longitude ?? _longitude,
      timestamp ?? _timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_latitude': _latitude,
      '_longitude': _longitude,
      '_timestamp': _timestamp,
    };
  }

  factory GeoData.fromMap(Map<String, dynamic> map) {
    return GeoData(
      map['_latitude']?.toDouble() ?? 0.0,
      map['_longitude']?.toDouble() ?? 0.0,
      DateTime.parse(map['_timestamp']),
    );
  }
  
  factory GeoData.fromJson(String source) => GeoData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'GeoData(_latitude: $_latitude, _longitude: $_longitude, _timestamp: $_timestamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeoData && other._latitude == _latitude && other._longitude == _longitude && other._timestamp == _timestamp;
  }

  @override
  int get hashCode => _latitude.hashCode ^ _longitude.hashCode ^ _timestamp.hashCode;
}
