import 'package:bb/Header.dart';
import 'package:flutter/material.dart';
import 'package:bb/utils/app_colors.dart';

class NotificationApp extends StatefulWidget {
  const NotificationApp({super.key});

  @override
  State<NotificationApp> createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),

      body: Center(
        child: Text(
          "Empty Notification",
          style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
