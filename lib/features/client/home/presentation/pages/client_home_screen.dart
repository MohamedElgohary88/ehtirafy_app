import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية - عميل'),
      ),
      body: const Center(
        child: Text('Client Home Placeholder'),
      ),
    );
  }
}

