import 'package:flutter/material.dart';
import 'package:Guide/StartPages/log_in.dart';
import 'package:Guide/firebase_auth_services.dart';
import 'package:Guide/global/common/toast.dart';
import 'package:Guide/widgets/from_conteiner_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  static const screenRoute = '/signup';

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  bool _isSigningup = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/7.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "LET'S \nDISCOVER EGYPT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            FromConteinerWidget(
              controller: _usernameController,
              hintText: "User Name",
              isPasswordField: false,
            ),
            SizedBox(height: 20.h),
            FromConteinerWidget(
              controller: _emailController,
              prefixIcon: Icons.email,
              hintText: "Email",
              isPasswordField: false,
            ),
            SizedBox(height: 20.h),
            FromConteinerWidget(
              controller: _passwordController,
              prefixIcon: Icons.lock,
              hintText: "Password",
              isPasswordField: true,
            ),
            SizedBox(height: 50.h),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: _signup,
                  child: _isSigningup
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Container(
              width: 250.w,
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an Account!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Login.screenRoute);
                      },
                      child: Text(
                        "Log in ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() async {
    setState(() {
      _isSigningup = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signUpWithEmailAndPassword(email, password, username);

    setState(() {
      _isSigningup = false;
    });

    if (user != null) {
      showToast(message: "User Is Successfully Created");
      Navigator.of(context).pushReplacementNamed(Login.screenRoute);
    } else {
      showToast(message: "Something Not Correct");
    }
  }
}
