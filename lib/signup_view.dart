import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_0/home_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    moveToHome() async {
      SharedPreferences userPref = await SharedPreferences.getInstance();

      userPref.setBool("isLogin", true);
      userPref.setString("userName", _nameController.text);
      userPref.setString("userEmail", _emailController.text);
      userPref.setString("userPassword", _passwordController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ));
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.05),
        child: ListView(
          children: [
            const Text(
              "SignUp",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.length < 3 || value!.isEmpty) {
                          return "Add at least three characters";
                        } else {
                          return null;
                        }
                      },
                      decoration: textFieldDecoration("Enter Your name"),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.contains("@") && value.endsWith(".com")) {
                          return null;
                        } else {
                          return "Please enter a valid emial";
                        }
                      },
                      decoration: textFieldDecoration("Enter our email"),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.length < 8 || value!.isEmpty) {
                          return "Password at least should be 8 characters";
                        } else {
                          return null;
                        }
                      },
                      decoration: textFieldDecoration("Enter your password"),
                    )
                  ],
                )),
            SizedBox(
              height: height * 0.1,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    moveToHome();
                  }
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ))
          ],
        ),
      ),
    );
  }
}
