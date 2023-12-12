import 'package:flutter/material.dart';
import 'package:manifest/Models/user.dart';
import 'package:manifest/Models/userTrips.dart';
import 'package:manifest/Models/waymodel.dart';
// import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void updateUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
   void updateUserTrips(int count) {
  if (_user != null) {
    _user!.tripCount = count;
    notifyListeners();
  }
}

  void updateUserWaybills(int count) {
    if(_user != null){
      _user!.waybillCount = count;
    notifyListeners();
    }
  }

  void updateUserReports() {
    if(_user != null){
       _user!.reportCount++;
    notifyListeners();
    }
  }

void addTripToHistory(UserTrip trip) {
   updateUserTrips(_user!.tripsHistory.length + 1);
  _user!.tripsHistory.add(trip); // Update trip count after adding a trip
  notifyListeners();
}


void addWaybillToHistory(WayTrip waybill) {
  updateUserWaybills(_user!.waybillsHistory.length + 1);
   _user!.waybillsHistory.add(waybill);
  notifyListeners();
}

}
