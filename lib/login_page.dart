import 'package:flutter/material.dart';
import 'package:helloworld/services/auth_service.dart';
import 'package:helloworld/utilities/spaces.dart';
import 'package:helloworld/widgets/login_textfield.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);
      await context.read<AuthService>().loginUser(userNameController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: userNameController.text);
      print('login successful');
    } else {
      print('login not successful');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _buildHeader(context) {
    return Column(
      children: [
        const Text(
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
      ],
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text('FIND US ON'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SocialMediaButton.github(), SocialMediaButton.linkedin()],
        ),
      ],
    );
  }

  Widget _buildForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              LoginTextField(
                  controller: userNameController,
                  hintText: 'USERNAME',
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 5) {
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
            onPressed: () async {
              await loginUser(context);
            },
            child: const Text(
              'LOG IN',
              style: TextStyle(fontSize: 14),
            )),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {},
          child: const Column(
            children: [
              Text('FORGOT PASSWORD?'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1000) {
              return Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeader(context),
                        _buildFooter(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(child: _buildForm(context)),
                  const Spacer(),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                _buildForm(context),
                _buildFooter()
              ],
            );
          }),
        ),
      ),
    );
  }
}
