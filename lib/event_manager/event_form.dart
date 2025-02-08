import 'package:flutter/material.dart';

class HostedEventsScreen extends StatelessWidget {
  const HostedEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주최한 행사'),
      ),
      body: const Center(
        child: Text('주최한 행사 화면입니다.'),
      ),
    );
  }
}