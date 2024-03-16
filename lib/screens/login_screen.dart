import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rayig/screens/sign_up_screen.dart';
import '../widgets/navbar_roots.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Consider a gradient or pattern
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500), // Adjusted duration
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 30.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                SizedBox(height: 40),
                Image.asset(
                  'icons/logo.png',
                  height: 300, // Adjusted size
                ),
                SizedBox(height: 30),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _textField("Username", _usernameController),
          SizedBox(height: 15),
          _textField("Password", _passwordController, isPassword: true),
          SizedBox(height: 20),
          _loginButton(),
          SizedBox(height: 20),
          _createAccountButton(),
        ],
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200], // Consider a light color
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
  Widget _loginButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavBarRoots()));
      },
      color: Color(0xFFa04e68),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      height: 50,
      child: Center(
        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _createAccountButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text("Create Account", style: TextStyle(color: Color(0xFFa04e68))),
      ),
    );
  }
}
