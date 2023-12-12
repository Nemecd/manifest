import 'package:flutter/material.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({super.key});

  @override
  State<AboutusScreen> createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transport Drivers Health Care Safety Initiative',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Registered with Corporate Affairs Commission in Nigeria(RC NO:156652), we are committed to providing transport drivers with the best care in health and safety.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Our online manifest aims to control and ensure road safety management for both drivers and passengers while on transit.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10.0),
                Text(
                  'transportdriverscare@gmail.com', // Replace with the actual email
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10.0),
                Text(
                  '+2348107541065', // Replace with the actual phone number
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Inter', // Assuming 'Inter' is imported and available as a font family
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}