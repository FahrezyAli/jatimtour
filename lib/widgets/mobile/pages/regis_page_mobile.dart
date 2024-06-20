import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../universal/views/regis_view.dart';

class RegistrationPageMobile extends StatelessWidget {
  const RegistrationPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30.0,
            width: MediaQuery.sizeOf(context).width,
            child: Positioned.fill(
              child: Image.asset(
                'assets/images/header.png',
                repeat: ImageRepeat.repeatX,
              ),
            ),
          ),
          const RegistrationView(),
        ],
      ),
    );
  }
}
