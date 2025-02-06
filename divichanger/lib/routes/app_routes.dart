import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';
  static const String historyScreen = '/history_screen';
  static const String loginScreen = '/login';

  static final Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => const HomeScreen(),
    historyScreen: (context) => const HistoryScreen(),
    loginScreen: (context) => const LoginScreen(),
  };
}
