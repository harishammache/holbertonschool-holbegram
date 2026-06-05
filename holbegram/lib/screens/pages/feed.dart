import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Holbegram',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Billabong',
                fontSize: 32,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/logo.png',
              width: 30,
              height: 30,
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.message_outlined, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.send_outlined, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: const Posts(),
    );
  }
}