import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/mobile/pages/main_page_mobile.dart';
import 'package:jatimtour/multi/entities/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;

  bool _isVisible = false;

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
                textInputAction: TextInputAction.next,
                onSaved: (email) => _email = email!,
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
                    suffixIcon: IconButton(
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
                  ),
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14.0,
                  ),
                  onSaved: (password) => _password = password!,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InkWell(
              child: Ink(
                height: 40.0,
                width: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: const Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/google_logo.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Log in with Google",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: RichText(
              text: TextSpan(
                text: "Log in →",
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20.0,
                  decoration: TextDecoration.underline,
                  color: Color(0xFFF15BF5),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainPageMobile(),
                      ),
                    );
                  },
              ),
            ),
          )
        ],
      ),
    );
  }
}