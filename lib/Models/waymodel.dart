class WayTrip {
  final String wayNumber;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String origination;
  final String destination;
  final DateTime dateTime;

  WayTrip({
    required this.wayNumber, 
    required this.senderName, 
    required this.senderPhone, 
    required this.receiverName, 
    required this.receiverPhone, 
    required this.origination,
    required this.destination, 
    required this.dateTime
    });
       Map<String, dynamic> toJson() {
    return {
      'wayNumber':wayNumber,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'origination': origination,
      'destination': destination,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory WayTrip.fromJson(Map<String, dynamic> json) {
    return WayTrip(
      wayNumber: json['wayNumber'],
      senderName: json['senderName'],
      senderPhone: json['sendPhone'],
      receiverName: json['receiverName'],
      receiverPhone: json['receiverPhone'],
      origination: json['origination'],
      destination: json['destination'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
