import 'dart:convert';

class RequestData {
  String? courierMac;
  DateTime? dataStart;
  DateTime? dataFinish;
  RequestData({
    this.courierMac,
    this.dataStart,
    this.dataFinish,
  });

  RequestData copyWith({
    String? courierMac,
    DateTime? dataStart,
    DateTime? dataFinish,
  }) {
    return RequestData(
      courierMac: courierMac ?? this.courierMac,
      dataStart: dataStart ?? this.dataStart,
      dataFinish: dataFinish ?? this.dataFinish,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courierMac': courierMac,
      'data_start': dataStart?.millisecondsSinceEpoch,
      'data_finish': dataFinish?.millisecondsSinceEpoch,
    };
  }

  factory RequestData.fromMap(Map<String, dynamic> map) {
    return RequestData(
      courierMac: map['courierMac'],
      dataStart: map['data_start'] != null ? DateTime.parse(map['data_start']) : null,
      dataFinish: map['data_finish'] != null ? DateTime.parse(map['data_finish']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestData.fromJson(String source) => RequestData.fromMap(json.decode(source));

  @override
  String toString() => 'RequestData(courierMac: $courierMac, dataFrom: $dataStart, dataTo: $dataFinish)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RequestData &&
      other.courierMac == courierMac &&
      other.dataStart == dataStart &&
      other.dataFinish == dataFinish;
  }

  @override
  int get hashCode => courierMac.hashCode ^ dataStart.hashCode ^ dataFinish.hashCode;
}
