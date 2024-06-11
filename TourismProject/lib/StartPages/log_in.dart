import 'package:flutter/material.dart';
import 'package:Guide/StartPages/home_page.dart';
import 'package:Guide/StartPages/sign_up.dart';
import 'package:Guide/widgets/from_conteiner_widget.dart';
import 'package:Guide/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const screenRoute = '/login';

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _isSigningin = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
              width: 300.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 253, 253),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: _signIn,
                  child: _isSigningin
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 100.h),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen()));
                },
                child: Text(
                  "Forgot Password ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //SizedBox(height: 20),
            Container(
              width: 250.w,
              height: 80.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account?",
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
                            .pushReplacementNamed(Signup.screenRoute);
                      },
                      child: Text(
                        "Sign up ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigningin = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('email', _emailController.text);
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigningin = false;
    });

    if (user != null) {
      print("User Is Successfully Signed in");
      Navigator.of(context).pushReplacementNamed(Homepage.screenRoute);
    } else {
      print("Something Not Correct");
    }
  }
}
