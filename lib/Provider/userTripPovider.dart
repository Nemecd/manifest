
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
       Timestamp dateTimeStamp = Timestamp.fromDate(trip.dateTime);
      await userTrips.doc(uid).collection('trips').add({
        'name': trip.name,
        'gender': trip.gender,
        'emergencyContactName': trip.emergencyNameContact,
        'emergencyContactPhone': trip.emergencyPhoneContact,
        'address': trip.address,
        'origination': trip.origination,
        'destination': trip.destination,
        'dateTime': dateTimeStamp,
      });
       // ignore: use_build_context_synchronously
       Provider.of<UserProvider>(context, listen: false).addTripToHistory(trip);
      notifyListeners();
    } catch (e) {
      print('Error saving trip: $e');
    }
  }
}
class GetTripProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserTrip>> getUserTrips(String userId) async {
    List<UserTrip> trips = [];
print('User ID: $userId');

    try {
      QuerySnapshot tripSnapshot = await _firestore
          .collection('userTrips')
          .doc(userId)
          .collection('trips')
          .get();
 print('Number of trip documents retrieved: ${tripSnapshot.size}');
      tripSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> tripData = document.data() as Map<String, dynamic>;
        UserTrip trip = UserTrip.fromJson(tripData); // Use your fromMap constructor
        trips.add(trip);
        print('Added trip: $trip');
        // After retrieving data from Firestore
print(tripData['dateTime'].runtimeType);

      });
    } catch (e) {
      print('Error retrieving trips: $e');
    }

    return trips;
  }
}
