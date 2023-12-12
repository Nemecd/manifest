import 'package:manifest/Models/userTrips.dart';
import 'package:manifest/Models/waymodel.dart';

class UserModel {
  final String userId; // Add this property
  final String name;
  final String phoneNumber;
  final String email;
  int tripCount;
  int waybillCount;
  int reportCount;
  List<UserTrip> tripsHistory;
  List<WayTrip> waybillsHistory;

  UserModel({
    required this.userId, // Initialize the userID in the constructor
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.tripCount = 0,
    this.waybillCount = 0,
    this.reportCount = 0,
    List<UserTrip>? tripsHistory,
    List<WayTrip>? waybillsHistory,
  })  : tripsHistory = List<UserTrip>.from(tripsHistory ?? []),
        waybillsHistory = List<WayTrip>.from(waybillsHistory ?? []);

  Map<String, dynamic> toJson() {
    return {
      'userID': userId, // Include userID in the serialization
      'name': name,
      'phoneNumber': phoneNumber,
      'tripCount': tripCount,
      'waybillCount': waybillCount,
      'reportCount': reportCount
    };
  }
  UserModel copyWith({
    List<UserTrip>? tripsHistory,
    List<WayTrip>? waybillsHistory, required int tripCount, required int waybillCount, required int reportCount,
  }) {
    return UserModel(
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      tripCount: tripCount,
      waybillCount: waybillCount,
      reportCount: reportCount,
      tripsHistory: tripsHistory ?? this.tripsHistory,
      waybillsHistory: waybillsHistory ?? this.waybillsHistory,
    );
  }
}

