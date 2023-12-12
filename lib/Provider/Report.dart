import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:manifest/Provider/provider.dart';

import '../Models/report.dart';

class ReportProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveReport(BuildContext context, CheckboxData report) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference userReports = _firestore.collection('userReports');
      await userReports.doc(uid).collection('reports').add({
        // Add the fields from CheckboxData that need to be stored
        'checkboxValue1': report.checkboxValue1,
        'checkboxValue2': report.checkboxValue2,
        'checkboxValue3': report.checkboxValue3,
        'checkboxValue4': report.checkboxValue4,
        'checkboxValue5': report.checkboxValue5,
        'checkboxValue6': report.checkboxValue6,
        'checkboxValue7': report.checkboxValue7,
        'checkboxValue8': report.checkboxValue8,
        'checkboxValue9': report.checkboxValue9,
        'checkboxValue10': report.checkboxValue10,
        'checkboxValue11': report.checkboxValue11,
        'checkboxValue12': report.checkboxValue12,
        'checkboxValue13': report.checkboxValue13,
        'checkboxValue14': report.checkboxValue14,
        'checkboxValue15': report.checkboxValue15,
        'others': report.others,
        'imgUrl': report.imgUrl,
      });
      
      // Optionally, update the user's report count or perform other actions
      // Provider.of<UserProvider>(context, listen: false).updateUserReports();

      notifyListeners();
    } catch (e) {
      print('Error saving report: $e');
    }
  }
}

class GetReportProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CheckboxData>> getUserReports(String userId) async {
    List<CheckboxData> reports = [];

    try {
      QuerySnapshot reportSnapshot = await _firestore
          .collection('userReports')
          .doc(userId)
          .collection('reports')
          .get();

      reportSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> reportData = document.data() as Map<String, dynamic>;
        CheckboxData report = CheckboxData(
          // Map Firestore data to CheckboxData fields
          checkboxValue1: reportData['checkboxValue1'],
          checkboxValue2: reportData['checkboxValue2'],
          checkboxValue3: reportData['checkboxValue3'],
          checkboxValue4: reportData['checkboxValue4'],
          checkboxValue5: reportData['checkboxValue5'],
          checkboxValue6: reportData['checkboxValue6'],
          checkboxValue7: reportData['checkboxValue7'],
          checkboxValue8: reportData['checkboxValue8'],
          checkboxValue9: reportData['checkboxValue9'],
          checkboxValue10: reportData['checkboxValue10'],
          checkboxValue11: reportData['checkboxValue11'],
          checkboxValue12: reportData['checkboxValue12'],
          checkboxValue13: reportData['checkboxValue13'],
          checkboxValue14: reportData['checkboxValue14'],
          checkboxValue15: reportData['checkboxValue15'],
          others: reportData['others'],
          imgUrl: reportData['imgUrl'],
        );
        reports.add(report);
      });
    } catch (e) {
      print('Error retrieving reports: $e');
    }

    return reports;
  }
}
