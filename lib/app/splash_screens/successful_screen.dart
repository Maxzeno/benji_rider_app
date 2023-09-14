// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class SuccessfulScreen extends StatelessWidget {
  final String text;
  final String buttonTitle;
  final Function()? buttonAction;
  const SuccessfulScreen({
    super.key,
    required this.text,
    required this.buttonTitle,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          margin: const EdgeInsets.only(
            top: kDefaultPadding,
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              // Center(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height * 0.4,
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage(
              //           "assets/animations/splash_screen/successful.gif",
              //         ),
              //       ),
              //       shape: BoxShape.circle,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              SizedBox(
                width: 307,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(
                      0xFF676565,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.36,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              ElevatedButton(
                onPressed: buttonAction,
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: kAccentColor,
                  fixedSize: Size(media.width, 50),
                ),
                child: Text(
                  buttonTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
