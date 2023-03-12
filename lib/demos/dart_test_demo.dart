import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DartTestDemo extends StatefulWidget implements DemoWidget {
  const DartTestDemo({Key? key}) : super(key: key);
  static const String _title = 'Testing Demo';
  static const String _description = 'Try testing user journey.';

  @override
  State<DartTestDemo> createState() => _DartTestDemoState();
  @override
  String get title => DartTestDemo._title;

  @override
  String get description => DartTestDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.magnifyingGlass);
}

class _DartTestDemoState extends State<DartTestDemo> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _loggedIn = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usernameInput = TextField(
      key: const ValueKey("username"),
      controller: _usernameController,
      decoration: const InputDecoration(hintText: 'Username'),
    );
    final passwordInput = TextField(
      key: const ValueKey("password"),
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
    final button = ElevatedButton(
      onPressed: () {
        if (_usernameController.text == "user" &&
            _passwordController.text == "password") {
          setState(() {
            _loggedIn = true;
          });
        } else {
          setState(() {
            _error = "Incorrect password";
          });
        }
      },
      child: const Text(
        'Login',
      ),
    );
    final loginPage = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        usernameInput,
        passwordInput,
        if (_error != null) Text(_error!),
        button,
      ],
    );
    const homePage = Text("Hello");
    return Center(
      child: _loggedIn ? homePage : loginPage,
    );
  }
}
