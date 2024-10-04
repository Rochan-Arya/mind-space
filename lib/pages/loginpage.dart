import 'package:flutter/material.dart';
import 'package:mind_space/components/textbox.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  Loginpage({super.key, required this.showRegisterPage});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //controllerssss
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoading = false;

  Future signIn(BuildContext context) async {
    setState(() {
      isLoading = true; // Show the loading indicator
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect password. Please try again.'),
          ),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The email address is not valid.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.message}'),
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                    scale: 6,
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
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                    height: 470,
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
                          "L O G   I N",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
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

                        //forgot
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 169, 169),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //login
                        isLoading
                            ? CircularProgressIndicator(
                                color: Color.fromARGB(255, 255, 169, 169),
                              )
                            : GestureDetector(
                                onTap: () => signIn(context),
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
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
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
                    "New User?",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      "Register Now!",
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
