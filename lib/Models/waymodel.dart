import 'package:cloud_firestore/cloud_firestore.dart';

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
      'dateTime': dateTime,
    };
  }

factory WayTrip.fromJson(Map<String, dynamic> json) {
  return WayTrip(
    wayNumber: json['wayNumber'] ?? '', // Handling null for 'wayNumber'
    senderName: json['senderName'] ?? '', // Handling null for 'senderName'
    senderPhone: json['senderPhone'] ?? '', // Handling null for 'senderPhone'
    receiverName: json['receiverName'] ?? '', // Handling null for 'receiverName'
    receiverPhone: json['receiverPhone'] ?? '', // Handling null for 'receiverPhone'
    origination: json['origination'] ?? '', // Handling null for 'origination'
    destination: json['destination'] ?? '', // Handling null for 'destination'
    dateTime: json['dateTime'] != null ? (json['dateTime'] as Timestamp).toDate() : DateTime.now(),
  );
}

}
