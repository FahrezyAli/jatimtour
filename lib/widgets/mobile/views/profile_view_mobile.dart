import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/mobile/buttons/box_button_mobile.dart';

class ProfileViewMobile extends StatefulWidget {
  const ProfileViewMobile({super.key});

  @override
  State<ProfileViewMobile> createState() => _ProfileViewMobileState();
}

class _ProfileViewMobileState extends State<ProfileViewMobile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPinkColor,
      child: Column(
        children: [
          Image.asset(
            'assets/images/leading.png',
            repeat: ImageRepeat.repeatX,
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  top: 122.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage:
                            user_services.currentUser!.getProfilePicture(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          Text(
                            user_services.currentUser!.username,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            user_services.currentUser!.email,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxButtonMobile(
                            text: const Text(
                              "Edit",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                            color: kPurpleColor,
                            onTap: () async {
                              await Modular.to.pushNamed(editProfileRoute);
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: 20.0),
                          BoxButtonMobile(
                            text: const Text(
                              "Sign Out",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                            color: kPurpleColor,
                            onTap: () async {
                              await user_services.signOut();
                              Modular.to.navigate('/');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
