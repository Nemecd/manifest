import 'dart:convert';

import 'package:manifest/Models/userTrips.dart';
import 'package:manifest/Models/waymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserTripsToSharedPreferences(String userId, List<UserTrip> trips) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> serializedTrips = trips.map((trip) => json.encode(trip.toJson())).toList();
  prefs.setStringList('userTrips_$userId', serializedTrips);
}

Future<List<UserTrip>> getUserTripsFromSharedPreferences(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? serializedTrips = prefs.getStringList('userTrips_$userId');
  if (serializedTrips != null) {
    return serializedTrips.map((serializedTrip) => UserTrip.fromJson(json.decode(serializedTrip))).toList();
  } else {
    return []; // Return an empty list as a default value if data is not available
  }
}


Future<void> saveUserWaybillToSharedPreferences(String userId, List<WayTrip> waybills) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> serializedWaybills = waybills.map((waybill) => json.encode(waybill.toJson())).toList();
  prefs.setStringList('userTrips_$userId', serializedWaybills);
}

Future<List<WayTrip>> getUserWaybillFromSharedPreferences(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? serializedTrips = prefs.getStringList('WayTrip_$userId');
  if (serializedTrips != null) {
    return serializedTrips.map((serializedTrip) => WayTrip.fromJson(json.decode(serializedTrip))).toList();
  } else {
    return [];
  }
}
