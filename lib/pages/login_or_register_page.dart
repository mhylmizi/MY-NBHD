import 'package:flutter/material.dart';
import 'package:my_nbhd_test/pages/login_page.dart';
import 'package:my_nbhd_test/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // INITIALLY SHOW LOGIN PAGE
  bool showLoginPage = true;

  // TOGGLE BETWEEN LOGIN / REGISTER
  void TogglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: TogglePages,
      );
    } else {
      return RegisterPage(
        onTap: TogglePages,
      );
    }
  }
}
