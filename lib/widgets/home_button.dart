import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HomeButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        textStyle: TextStyle(fontSize: 20),
      ),
      onPressed: onTap,
      child: Text(title),
    );
  }
}
