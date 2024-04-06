import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jatimtour/widgets/buttons/sign_button.dart';
import 'package:jatimtour/widgets/carousel/welcome_text_carousel.dart';
import 'package:jatimtour/widgets/pages/login_page.dart';
import 'package:jatimtour/widgets/pages/signup_page.dart';
import 'package:jatimtour/widgets/pages/welcome_page.dart';

class StartPageWeb extends StatefulWidget {
  final int state;

  const StartPageWeb({required this.state, super.key});

  @override
  State<StartPageWeb> createState() => _StartPageWebState();
}

class _StartPageWebState extends State<StartPageWeb> {
  late int _state;

  @override
  void initState() {
    super.initState();
    _state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBE2),
      body: Column(
        children: [
          Image.asset(
            'assets/images/header.png',
            height: 40.0,
            width: MediaQuery.sizeOf(context).width,
            repeat: ImageRepeat.repeatX,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 150.0),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Column(
                  children: [
                    const WelcomePage(),
                    Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: const WelcomeTextCarousel(),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 150.0),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: Column(
                  children: [
                    SignButton(
                      state: _state,
                      onStateChange: (state) => setState(
                        () {
                          _state = state;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Builder(
                        builder: (context) {
                          return _state == 1
                              ? FadeInLeft(child: const LoginPage())
                              : FadeInRight(child: const SignUpPage());
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
