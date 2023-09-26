import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/message_textformfield.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../src/widget/section/my_fixed_snackBar.dart';
import '../../theme/colors.dart';

class HelpnSupport extends StatefulWidget {
  const HelpnSupport({super.key});

  @override
  State<HelpnSupport> createState() => _HelpnSupportState();
}

class _HelpnSupportState extends State<HelpnSupport> {
  //============================================ ALL VARIABLES ===========================================\\
  bool _submittingRequest = false;

  //============================================ CONTROLLERS ===========================================\\
  TextEditingController _messageEC = TextEditingController();

  //============================================ FOCUS NODES ===========================================\\
  FocusNode _messageFN = FocusNode();

  //============================================ KEYS ===========================================\\
  GlobalKey<FormState> _formKey = GlobalKey();

  //============================================ FUNCTIONS ===========================================\\
  //========================== Save data ==================================\\
  Future<void> _submitRequest() async {
    setState(() {
      _submittingRequest = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 1));

    //Display snackBar
    myFixedSnackBar(
      context,
      "Your request has been submitted successfully".toUpperCase(),
      kAccentColor,
      const Duration(seconds: 3),
    );

    Future.delayed(const Duration(seconds: 1), () {
      // Navigate to the new page
      Navigator.of(context).pop(context);

      setState(() {
        _submittingRequest = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: "Help and support",
        elevation: 10.0,
        actions: [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      bottomNavigationBar: _submittingRequest
          ? Center(
              child: SpinKitDoubleBounce(
                color: kAccentColor,
              ),
            )
          : Container(
              color: kPrimaryColor,
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: MyElevatedButton(
                onPressed: (() async {
                  if (_formKey.currentState!.validate()) {
                    _submitRequest();
                  }
                }),
                title: "Submit",
              ),
            ),
      body: SafeArea(
        child: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(child: SpinKitDoubleBounce(color: kAccentColor));
            }
            if (snapshot.connectionState == ConnectionState.none) {
              const Center(
                child: Text("Please connect to the internet"),
              );
            }
            // if (snapshot.connectionState == snapshot.requireData) {
            //   SpinKitDoubleBounce(color: kAccentColor);
            // }
            if (snapshot.connectionState == snapshot.error) {
              const Center(
                child: Text("Error, Please try again later"),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(kDefaultPadding),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  width: 292,
                  child: Text(
                    'We will like to hear from you',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                kHalfSizedBox,
                SizedBox(
                  width: 332,
                  child: Text(
                    '',
                    style: TextStyle(
                      color: kTextGreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 2),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyMessageTextFormField(
                        controller: _messageEC,
                        validator: (value) {
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        focusNode: _messageFN,
                        hintText: "Enter your message here",
                        maxLines: 10,
                        keyboardType: TextInputType.text,
                        maxLength: 6000,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
