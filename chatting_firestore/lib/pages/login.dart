import 'package:flutter/material.dart';
import '../services/authentication_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Log in'),
          onPressed: () {
            _authService.login().then((user) {
              if (user.role == 'customer') {
                Navigator.pushReplacementNamed(context, '/fixerList');
              } else if (user.role == 'fixer') {
                Navigator.pushReplacementNamed(context, '/chat');
              }
            }).catchError((error) {
              // Handle login error
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(error.toString()),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            });
          },
        ),
      ),
    );
  }
}