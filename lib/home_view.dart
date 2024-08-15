import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_0/signup_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEnabled = false;
  logoutUser() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignupView(),
        ));
  }

  final _formKey = GlobalKey<FormState>();
  textFieldValues() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();

    userPref.setBool("isLogin", true);
    _nameController.text = userPref.getString("userName").toString();
    _emailController.text = userPref.getString("userEmail").toString();
    _passwordController.text = userPref.getString("userPassword").toString();
  }

  editValues() {
    setState(() {
      isEnabled = true;
    });
  }

  onDone() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.setString("userName", _nameController.text);
    userPref.setString("userEmail", _emailController.text);
    userPref.setString("userPassword", _passwordController.text);
    setState(() {
      isEnabled = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldValues();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                logoutUser();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "HomePage",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onPressed: _showMyDialog,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.05),
        child: ListView(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: isEnabled,
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
                        enabled: isEnabled,
                        controller: _emailController,
                        validator: (value) {
                          if (value!.contains("@") && value.endsWith(".com")) {
                            return null;
                          } else {
                            return "Please enter a valid email";
                          }
                        },
                        decoration: textFieldDecoration(
                          "Enter Your email",
                        )),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                        obscureText: true,
                        enabled: isEnabled,
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.length < 8 || value!.isEmpty) {
                            return "Password at least should be 8 characters";
                          } else {
                            return null;
                          }
                        },
                        decoration: textFieldDecoration("Enter Your password"))
                  ],
                )),
            SizedBox(
              height: height * 0.1,
            ),
            isEnabled
                ? ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onDone();
                      }
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                : ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: editValues,
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

InputDecoration textFieldDecoration(String title) {
  return InputDecoration(
    hintText: title,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
  );
}
