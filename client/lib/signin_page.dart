// ignore_for_file: use_build_context_synchronously

import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'email_password_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).size.height * 0.25;
    final double paddingX = MediaQuery.of(context).size.width * 0.15;
    final double dividerIndent = MediaQuery.of(context).size.width * 0.15;

    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [
            0.1,
            0.3,
            0.5,
            0.7,
            0.9
          ],
              colors: [
            Colors.blue.shade300,
            Colors.blue.shade200,
            Colors.blue.shade100,
            Colors.blue.shade200,
            Colors.blue.shade300,
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: paddingTop),
                child: const Text(
                  "FitSync",
                  style: TextStyle(fontSize: 90),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingX),
                child: EmailPasswordForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ),
              Divider(
                indent: dividerIndent,
                endIndent: dividerIndent,
                color: theme.dividerColor,
              ),
            ]),
          )),
    );
  }
}
