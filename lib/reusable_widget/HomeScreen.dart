import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 90),
          const Center(
            child: Text(
              "Sign in as",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 8),
          user != null
              ? Center(
                  child: Column(
                    children: [
                      Text(
                        user?.uid ?? "vanshika Wadhwa",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user?.email ?? "vanshika Wadhwa",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user?.displayName ?? "vanshika Wadhwa",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250, // Set the width as per your preference
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              debugPrint("Signed Out");
                            });
                          },
                          child: const Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "Unknown User",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
