
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/Models/waymodel.dart';
import 'package:manifest/Provider/provider.dart';
import 'package:provider/provider.dart';

class WayProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWaybillInfo(BuildContext context, WayTrip waybill) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference userTrips = _firestore.collection('waybillTrips');
      
      await userTrips.doc(uid).collection('waybills').add({
        'waybillNumber': waybill.wayNumber,
        'senderName': waybill.senderName,
        'senderPhoneNumber': waybill.senderPhone,
        'receiverName' : waybill.receiverName,
        'receiverPhone': waybill.receiverPhone,
        'origination' : waybill.origination,
        'destination': waybill.destination,
        'dateTime': waybill.dateTime,
      });
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).addWaybillToHistory(waybill);
      notifyListeners();
    } catch (e) {
      print('Error saving trip: $e');
    }
  }
}