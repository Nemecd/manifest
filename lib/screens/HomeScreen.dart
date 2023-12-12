
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manifest/Models/user.dart';
import 'package:manifest/Provider/provider.dart';
import 'package:manifest/screens/detailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/report.dart';
import '../Models/userTrips.dart';
import '../Models/waymodel.dart';
import '../NotificationScreen.dart';
import '../Provider/Report.dart';
import '../Provider/notifyProvider.dart';
import '../Provider/userTripPovider.dart';
import '../Provider/wayProvider.dart';
import 'SigninScreen.dart';

class DashuserScreen extends StatefulWidget {
  final String userId;
  const DashuserScreen({
    super.key,
    required this.userId,
  });

  @override
  State<DashuserScreen> createState() => _DashuserScreenState();
}

class _DashuserScreenState extends State<DashuserScreen> {
  late UserModel user;
  List<UserTrip> userTrips = [];
  List<WayTrip> wayTrips = [];

  @override
  void initState() {
    super.initState();
    loadUserData();

    user = UserModel(
      userId: '',
      name: '',
      phoneNumber: '',
      email: '',
      tripCount: 0,
      waybillCount: 0,
      reportCount: 0,
      waybillsHistory: [],
      tripsHistory: [],
    );
  }

  Future<void> loadData() async {
    try {
      GetTripProvider tripProvider = GetTripProvider();
      String userId = FirebaseAuth.instance.currentUser!.uid;

      List<UserTrip> trips = await tripProvider.getUserTrips(userId);

      GetWayProvider wayProvider = GetWayProvider();
      List<WayTrip> waybills = await wayProvider.fetchWayTrips(userId);
       List<CheckboxData> report = await Provider.of<GetReportProvider>(context, listen: false)
        . getUserReports(userId);
      setState(() {
        user = user.copyWith(
          tripCount: trips.length,
          waybillCount: waybills.length,
          reportCount: report.length,
          waybillsHistory: waybills,
          tripsHistory: trips,
        );
      });

      // Update the user data in the provider
      Provider.of<UserProvider>(context, listen: false).updateUser(user);

      print('Loaded ${user.tripsHistory.length} user trips');
      print('Loaded ${user.waybillsHistory.length} waybill trips');
      print('Waybills count: ${user.waybillCount}');
      print('Trips count: ${user.tripCount}');
      print('Trips count: ${user.reportCount}');
    } catch (e) {
      print('Error loading user data: $e');
      // Handle error accordingly
    }
  }

  Future<void> loadUserData() async {
    try {
      UserModel? fetchedUser = await fetchData();

      if (fetchedUser != null) {
        setState(() {
          user = fetchedUser;
        });

        // loadUserTrips();
        // loadUserWay();
        loadData();
        
        // Update the user data in the provider
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
      } else {
        // Navigate to SigninScreen if user data is not available
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SigninScreen()),
        );
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Handle error accordingly
    }
  }

  Future<UserModel?> fetchData() async {
    try {
      // Fetch user data from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final userName = prefs.getString('userName');
      final userEmail = prefs.getString('userEmail');
      final userPhoneNumber = prefs.getString('userPhoneNumber');

      // Check if all necessary data is available
      if (userId != null &&
          userName != null &&
          userEmail != null &&
          userPhoneNumber != null) {
        return UserModel(
          userId: userId,
          name: userName,
          phoneNumber: userPhoneNumber,
          email: userEmail,
          // Add other necessary fields
        );
      } else {
        // Data is incomplete in shared preferences
        print('Incomplete user data in shared preferences');
        return null;
      }
    } catch (e) {
      print('Exception fetching user data from shared preferences: $e');
      throw Exception('Failed to fetch user data from shared preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      UserModel? user = userProvider.user;

      if (user == null) {
        // Display loading indicator while user data is being fetched
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        print('Waybills count: ${user.waybillsHistory.length}');
        print('Trips count: ${user.tripsHistory.length}');
        print('Report Count: ${user.reportCount}');
        return Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text('Welcome ${user.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                  )),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_active),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                      notificationProvider.markAllAsRead();
                    },
                  ),
                  if (notificationProvider.unreadNotificationsCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          '${notificationProvider.unreadNotificationsCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
            backgroundColor: const Color(0xFFf6fafd),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(
                    0xFFf6fafd), // Set the background color using a BoxDecoration
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: const Color(0xFF2062ff),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/img/card.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 215.0),
                    child: Text('Overview',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'inter',
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Card(
                          color: const Color(0xFFfec104),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                                child: Column(
                              children: [
                                Text(
                                  '${user.tripCount}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontFamily: 'inter'),
                                ),
                                const Text(
                                  'Trips',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0XFF9c7822),
                                      fontFamily: 'inter'),
                                )
                              ],
                            )),
                          ),
                        ),
                        Card(
                          color: const Color(0xFFdf07d6),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    '${user.waybillCount}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontFamily: 'inter'),
                                  ),
                                  const Text(
                                    'Waybills',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0XFF892184),
                                        fontFamily: 'inter'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: const Color(0xFF07d4e7),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    '${user.reportCount}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontFamily: 'inter'),
                                  ),
                                  const Text(
                                    'Reports',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0XFF22848e),
                                        fontFamily: 'inter'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 240.0),
                    child: Text('History',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'inter',
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ListView.builder(
                        itemCount: user.waybillsHistory.length +
                            user.tripsHistory.length,
                        itemBuilder: (context, index) {
                          if (index < user.waybillsHistory.length) {
                            // Build a card for waybill
                            WayTrip waybill = user.waybillsHistory[index];
                            return buildWaybillCard(context, waybill);
                          } else {
                            // Build a card for trip
                            int tripIndex = index - user.waybillsHistory.length;
                            UserTrip trip = user.tripsHistory[tripIndex];
                            return buildTripCard(context, trip);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        });
      }
    });
  }
}

Widget buildWaybillCard(BuildContext context, WayTrip waybill) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            origination: waybill.origination,
            destination: waybill.destination,
            dateTime: waybill.dateTime.toString(),
            waybillNumber: waybill.wayNumber,
          ),
        ),
      );
    },
    child: Card(
      color: const Color(0xFF9db0da),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.local_shipping), // Waybill icon
        title: Text(
          'From: ${waybill.origination} to: ${waybill.destination}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 15, fontFamily: 'inter'),
        ),
        subtitle: const Text(
          'Description: Waybill',
          style: TextStyle(
              color: Color(0xFFd4dced), fontSize: 10, fontFamily: 'inter'),
        ),
      ),
    ),
  );
}

Widget buildTripCard(BuildContext context, UserTrip trip) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            origination: trip.origination,
            destination: trip.destination,
            dateTime: trip.dateTime.toString(),
            waybillNumber: null,
          ),
        ),
      );
    },
    child: Card(
      color: const Color(0xFF9db0da),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.directions_car), // Trip icon
        title: Text(
          'From: ${trip.origination} to: ${trip.destination}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 15, fontFamily: 'inter'),
        ),
        subtitle: Text(
          'Date: ${trip.dateTime}',
          style: const TextStyle(
              color: Color(0xFFd4dced), fontSize: 10, fontFamily: 'inter'),
        ),
      ),
    ),
  );
}
