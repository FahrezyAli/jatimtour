import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/user_services.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypedPasswordController = TextEditingController();
  bool _isVisible = false;
  Timer timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    checkEmailVerified((verified) {
      if (verified) {
        Modular.to.navigate(regisRoute);
        timer.cancel();
      }
    });
  });

  Future<void> _signUp() async {
    if (!EmailValidator.validate(_emailController.text)) {
      _showErrorSnackBar("Email is not valid");
    } else if (_passwordController.text.length < 6) {
      _showErrorSnackBar("Password must be at least 6 characters");
    } else if (_passwordController.text != _retypedPasswordController.text) {
      _showErrorSnackBar("Password and Retyped Password do not match");
    } else {
      await signIn(
        email: _emailController.text,
        password: _passwordController.text,
      ).catchError(
        (e) {
          _showErrorSnackBar(
            e.toString(),
          );
        },
      );
      await sendVerificationEmail();
      _showErrorSnackBar(
        "An email has been sent to your email address, check you email to continue",
        pretext: false,
      );
    }
  }

  void _showErrorSnackBar(String error, {bool pretext = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          pretext ? "Sign Up Error: $error" : error,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _suffixPasswordIcon() {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: false,
      child: IconButton(
        icon: Icon(
          _isVisible ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFFF15BF5),
        ),
        onPressed: () => setState(
          () {
            _isVisible = !_isVisible;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypedPasswordController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            height: 40.0,
            width: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "email",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.0,
                ),
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 40.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "password",
                      hintStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      suffixIcon: _suffixPasswordIcon()),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 40.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: TextFormField(
                  controller: _retypedPasswordController,
                  obscureText: !_isVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "retype password",
                      hintStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14.0,
                      ),
                      suffixIcon: _suffixPasswordIcon()),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) async {
                    await _signUp();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
              text: TextSpan(
                text: "Sign Up →",
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                    color: Color(0xFFF15BF5)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await _signUp();
                  },
              ),
            ),
          )
        ],
      ),
    );
  }
}
