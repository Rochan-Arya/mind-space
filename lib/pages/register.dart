import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_space/components/textbox.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usernameController.text.trim(),
            password: passwordController.text.trim());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool passwordConfirmed() {
    if (passwordController == confirmpasswordController) {
      return true;
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/space.png",
                    scale: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "M I N D",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "S P A C E",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 169, 169),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Join Us to Breathe, Relax, and Thrive",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                    height: 520,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade900,
                            offset: Offset(5, 5),
                            blurRadius: 15.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(-5, -7),
                            blurRadius: 20.0,
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        //login
                        Text(
                          "S I G N  U P",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //username
                        MyTextBox(
                          controller: usernameController,
                          hintText: "Username",
                          obscureText: false,
                        ),

                        //pass
                        MyTextBox(
                          hintText: "Password",
                          obscureText: true,
                          controller: passwordController,
                        ),
                        //confirm
                        MyTextBox(
                          hintText: "Confirm Password",
                          obscureText: true,
                          controller: confirmpasswordController,
                        ),

                        //forgot
                        SizedBox(
                          height: 20,
                        ),

                        //login
                        isLoading
                            ? CircularProgressIndicator(
                                color: const Color.fromARGB(255, 255, 169, 169),
                              )
                            : GestureDetector(
                                onTap: () => signUp(),
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color.fromARGB(
                                        255, 255, 169, 169),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "SignUP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 15,
                        ),

                        //or google apple
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 1,
                                width: 122,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 1,
                                width: 120,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: Image.asset(
                                "assets/images/search.png",
                                scale: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              child: Icon(
                                Icons.apple_sharp,
                                size: 40,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a User!",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      "Sign In!",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 169, 169),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
