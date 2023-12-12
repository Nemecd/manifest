import 'package:flutter/material.dart';

import '../Models/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  int _unreadNotificationsCount = 0; // Track unread notifications count

  List<NotificationModel> get notifications => _notifications;
  int get unreadNotificationsCount => _unreadNotificationsCount;

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    _unreadNotificationsCount++; // Increment count for each new notification
    notifyListeners();
  }

  void markAllAsRead() {
    _unreadNotificationsCount = 0; // Reset count when notifications are viewed
    notifyListeners();
  }
  
  // Other methods to retrieve, update, or clear notifications
}

