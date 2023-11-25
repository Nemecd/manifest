import 'package:manifest/Models/userTrips.dart';
import 'package:manifest/Models/waymodel.dart';

class UserModel {
  final String name;
  final String phoneNumber;
  final String email;
  int tripCount;
  int waybillCount;
  int reportCount;
  List<UserTrip> tripsHistory;
  List<WayTrip> waybillsHistory;

  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.tripCount = 0, // Default count initialized to 0
    this.waybillCount = 0,
    this.reportCount = 0,
   List<UserTrip>? tripsHistory, // Allow initialization from constructor
    List<WayTrip>? waybillsHistory, // Allow initialization from constructor
  })  : tripsHistory = List<UserTrip>.from(tripsHistory ?? []),
        waybillsHistory = List<WayTrip>.from(waybillsHistory ?? []);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'tripCount': tripCount,
      'waybillCount': waybillCount,
    };
  }
}
