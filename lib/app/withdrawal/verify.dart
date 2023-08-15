import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:benji_rider/app/withdrawal/select_account.dart';
import 'package:benji_rider/app/withdrawal/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my textformfield.dart';
import '../../src/widget/form_and_auth/otp_textFormField.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../src/widget/section/my_fixed_snackBar.dart';
import '../../theme/colors.dart';
import '../splash_screens/successful_screen.dart';

class VerifyWithdrawalPage extends StatefulWidget {
  const VerifyWithdrawalPage({Key? key}) : super(key: key);

  @override
  State<VerifyWithdrawalPage> createState() => _VerifyWithdrawalPageState();
}

class _VerifyWithdrawalPageState extends State<VerifyWithdrawalPage> {
//===================================== ALL VARIABLES =========================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController pin1EC = TextEditingController();
  TextEditingController pin2EC = TextEditingController();
  TextEditingController pin3EC = TextEditingController();
  TextEditingController pin4EC = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  FocusNode pin1FN = FocusNode();
  FocusNode pin2FN = FocusNode();
  FocusNode pin3FN = FocusNode();
  FocusNode pin4FN = FocusNode();

  //=========================== BOOL VALUES====================================\\
  bool isLoading = false;

  //=========================== FUNCTIONS ====================================\\
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    //Display snackBar
    myFixedSnackBar(
      context,
      "OTP Verified".toUpperCase(),
      kSecondaryColor,
      const Duration(
        seconds: 2,
      ),
    );

    // Navigate to the new page
    Get.offAll(
      () => SuccessfulScreen(
        buttonTitle: 'Ok',
        text: 'Withdrawal Successful',
        buttonAction: () => Get.to(
          () => Dashboard(),
          routeName: 'Dashboard',
          duration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          preventDuplicates: true,
          popGesture: true,
          transition: Transition.rightToLeft,
        ),
      ),
      routeName: 'SuccessfulScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: true,
      transition: Transition.rightToLeft,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = formatDateAndTime(now);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -20,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Builder(
            builder: (context) => Row(
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: kAccentColor,
                  ),
                ),
                kHalfWidthSizedBox,
                Text(
                  "Verify Withdrawal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MyResponsiveWidth(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: 0.90,
                          child: Text(
                            'We have sent a code to your email',
                            style: TextStyle(
                              color: Color(0xFF454545),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.62,
                            ),
                          ),
                        ),
                        Text(
                          'example@gmail.com',
                          style: TextStyle(
                            color: Color(0xFF454545),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.48,
                          ),
                        ),
                        kSizedBox,
                        Opacity(
                          opacity: 0.90,
                          child: Text(
                            'Enter the code below to verify this withdrawal',
                            style: TextStyle(
                              color: Color(0xFF454545),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.62,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CODE',
                        style: TextStyle(
                          color: Color(0xFF31343D),
                          fontSize: 14.11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: Color(0xFF31343D),
                                fontSize: 15.20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: Color(0xFF31343D),
                                fontSize: 15.20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' in.50sec',
                              style: TextStyle(
                                color: Color(0xFF31343D),
                                fontSize: 15.20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  kSizedBox,
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 68,
                          child: MyOTPTextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (pin1) {
                              pin1EC.text = pin1!;
                            },
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                pin1FN.requestFocus();
                                return "";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          width: 68,
                          child: MyOTPTextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (pin2) {
                              pin2EC.text = pin2!;
                            },
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                pin2FN.requestFocus();
                                return "";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          width: 70,
                          child: MyOTPTextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (pin3) {
                              pin3EC.text = pin3!;
                            },
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                pin3FN.requestFocus();
                                return "";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          width: 68,
                          child: MyOTPTextFormField(
                            textInputAction: TextInputAction.done,
                            onSaved: (pin4) {
                              pin4EC.text = pin4!;
                            },
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nearestScope;
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                pin4FN.requestFocus();
                                return "";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  isLoading
                      ? Center(
                          child: SpinKitChasingDots(
                            color: kAccentColor,
                            duration: const Duration(seconds: 2),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: (() async {
                            if (_formKey.currentState!.validate()) {
                              loadData();
                            }
                          }),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: kAccentColor,
                            fixedSize: Size(media.width, 50),
                          ),
                          child: Text(
                            'Verify'.toUpperCase(),
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
        ),
      ),
    );
  }
}
