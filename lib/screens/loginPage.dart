import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();

    //try again
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
      // Navigator.pushNamed(context, '/main_screen');
    }

    //catch any error
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextfield(
                  hintText: 'Email..',
                  obscureText: false,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  hintText: 'Password..',
                  obscureText: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => login(context),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('Login')),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        "Register Here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
