import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/notifyProvider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List notifications = Provider.of<NotificationProvider>(context).notifications;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: const Color(0xFFf6fafd),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf6fafd),
        ),
        child: notifications.isEmpty
            ? Center(child: Text('No Notifications'))
            : ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black, // Black divider line between list items
                  thickness: 1.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        notifications[index].title,
                        style: TextStyle(
                          fontFamily: 'Inter', // Use 'Inter' font family
                          fontWeight: FontWeight.bold, // Bold title
                          fontSize: 16.0, // Adjust font size
                        ),
                      ),
                      subtitle: Text(
                        notifications[index].description,
                        style: TextStyle(
                          fontFamily: 'Inter', // Use 'Inter' font family
                          fontSize: 14.0, // Adjust font size
                        ),
                      ),
                      // Display timestamp or other details as needed
                    ),
                  );
                },
              ),
      ),
    );
  }
}
