import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  // register method
  void register(BuildContext context) {
    //get the auth service
    final _auth = AuthService();

    // passwords match -> create user
    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }

    //if paasword don't match -> tell user to fix
    else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Passowrds don't match!"),
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
                SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  hintText: 'Confirm Password..',
                  obscureText: true,
                  controller: _confirmpasswordController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => register(context),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('Register')),
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
                      "Already have an Account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/loginPage');
                      },
                      child: Text(
                        "Login Here",
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
