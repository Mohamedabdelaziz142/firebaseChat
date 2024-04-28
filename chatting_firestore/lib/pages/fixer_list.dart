import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firebase_service.dart';
import '../widgets/user_profile.dart';

class FixerListScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixer List'),
      ),
      body: FutureBuilder<List<User>>(
        future: _firestoreService.getFixersList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final fixers = snapshot.data;
            return ListView.builder(
              itemCount: fixers!.length,
              itemBuilder: (context, index) {
                final fixer = fixers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: UserProfile```dart
                  child: UserProfile(fixer),
                );
              },
            );
          }
        },
      ),
    );
  }
}