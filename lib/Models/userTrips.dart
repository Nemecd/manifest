import 'package:cloud_firestore/cloud_firestore.dart';

class UserTrip {
  final String name;
  final String gender;
  final String emergencyNameContact;
  final String emergencyPhoneContact;
  final String address;
  final String origination;
  final String destination;
  final DateTime dateTime;
  UserTrip({
    required this.name,
    required this.gender,
    required this.emergencyNameContact,
    required this.emergencyPhoneContact,
    required this.address,
    required this.origination,
    required this.destination,
    required this.dateTime,
  });
   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'emergencyNameContact': emergencyNameContact,
      'emergencyPhoneContact': emergencyPhoneContact,
      'address': address,
      'origination': origination,
      'destination': destination,
      'dateTime': dateTime,
    };
  }

  factory UserTrip.fromJson(Map<String, dynamic> json) {
    return UserTrip(
       name: json['name'] ?? '',
       gender: json['gender'] ?? '',
      emergencyNameContact: json['emergencyNameContact'] ?? '',
      emergencyPhoneContact: json['emergencyPhoneContact']?? '',
      address: json['address']?? '',
      origination: json['origination']?? '',
      destination: json['destination']?? '',
    dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }
}
