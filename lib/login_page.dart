import 'package:flutter/material.dart';
import 'package:helloworld/utilities/spaces.dart';
import 'package:helloworld/widgets/login_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  void loginUser(context) {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: '${userNameController.text}');
      print('login successful');
    } else {
      print('login not successful');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LOG IN',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              verticalSpacing(24),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/9374/9374940.png',
                height: 200,
              ),
              verticalSpacing(24),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    LoginTextField(
                        controller: userNameController,
                        hintText: 'USERNAME',
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 5) {
                            return "Your username must be more than 5 characters!";
                          } else if (value != null && value.isEmpty) {
                            return "Please enter your username!";
                          }
                          return null;
                        }),
                    verticalSpacing(24),
                    LoginTextField(
                        hasAsterisk: true,
                        controller: passwordController,
                        hintText: 'PASSWORD'),
                    verticalSpacing(24),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    loginUser(context);
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(fontSize: 14),
                  )),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Text('FORGOT PASSWORD?'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
