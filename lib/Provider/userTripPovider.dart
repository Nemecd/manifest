
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/Models/userTrips.dart';

import 'package:manifest/Provider/provider.dart';
import 'package:provider/provider.dart';

class TripProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveTripInfo(BuildContext context,UserTrip trip) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference userTrips = _firestore.collection('userTrips');
      
      await userTrips.doc(uid).collection('trips').add({
        'name': trip.name,
        'emergencyContactName': trip.emergencyNameContact,
        'emergencyContactPhone': trip.emergencyPhoneContact,
        'address': trip.address,
        'origination': trip.origination,
        'destination': trip.destination,
        'dateTime': trip.dateTime,
      });
       // ignore: use_build_context_synchronously
       Provider.of<UserProvider>(context, listen: false).addTripToHistory(trip);
      notifyListeners();
    } catch (e) {
      print('Error saving trip: $e');
    }
  }
}