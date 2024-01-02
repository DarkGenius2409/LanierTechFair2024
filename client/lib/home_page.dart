import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [TitleSection()],
        ),
      ),
    );
  }
}

class TitleSection extends StatefulWidget {
  const TitleSection({super.key});

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  final user = FirebaseAuth.instance.currentUser;
  late String username;

  @override
  void initState() {
    super.initState();
    username = user?.displayName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).size.height * 0.05;
    final double paddingX = MediaQuery.of(context).size.width * 0.1;
    final double dividerIndent = MediaQuery.of(context).size.width * 0.15;

    return Padding(
      padding:
          EdgeInsets.only(top: paddingTop, left: paddingX, right: paddingX),
      child: Column(
        children: [
          const Center(
              child: Text(
            "Welcome",
            style: TextStyle(fontSize: 60),
          )),
          Center(
              child: Text(
            username,
            style: const TextStyle(fontSize: 40),
          )),
        ],
      ),
    );
  }
}
