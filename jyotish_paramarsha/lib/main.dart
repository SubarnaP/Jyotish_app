import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Debug checks
  if (kDebugMode) {
    print('Running app in debug mode');
    print('Platform: ${defaultTargetPlatform.toString()}');
  }

  // Initialize services
  await NotificationService.instance.init();

  // Error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      print('Error: ${details.toString()}');
    }
  };

  runApp(const JyotishApp());
}
