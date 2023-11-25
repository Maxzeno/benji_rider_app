import 'package:benji_rider/src/widget/responsive/reponsive_width.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my textformfield.dart';
import '../../src/widget/form_and_auth/my_blue_textformfield.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../theme/colors.dart';
import 'select_bank.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({super.key});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
//===================================== INITIAL STATE =========================================\\
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

//===================================== ALL VARIABLES =========================================\\

//===================================== BOOL VALUES =========================================\\

//================= Controllers ==================\\
  final scrollController = ScrollController();
  final bankNameEC = TextEditingController();
  final accountNumberEC = TextEditingController();

//================= Focus Nodes ==================\\
  final bankNameFN = FocusNode();
  final bankNames = FocusNode();
  final accountNumberFN = FocusNode();

  final formKey = GlobalKey<FormState>();

  String dropDownItemValue = "Access Bank";

  //================================== FUNCTION ====================================\\

  void dropDownOnChanged(String? onChanged) {
    setState(() {
      dropDownItemValue = onChanged!;
    });
  }

  //=================================== Navigation ============================\\
  selectBank() async {
    final selectedBank = await Get.to(
      () => const SelectBank(),
      routeName: 'SelectBank',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
    );
    if (selectedBank != null) {
      setState(() {
        bankNameEC.text = selectedBank;
      });
    }
  }

  void saveAccount() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Add bank account",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: kAccentColor.withOpacity(0.08),
              offset: const Offset(3, 0),
              blurRadius: 32,
            ),
          ]),
          child: MyElevatedButton(
            title: "Save Account",
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                saveAccount();
              }
            },
            // isLoading: controller.isLoad.value,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            child: MyResponsiveWidth(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //   child: Text(
                    //     'Bank Details',
                    //     style: TextStyle(
                    //       color: kTextBlackColor,
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w600,
                    //       height: 1.45,
                    //     ),
                    //   ),
                    // ),
                    // kSizedBox,
                    Text(
                      'Bank Name',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    InkWell(
                      onTap: selectBank,
                      child: MyBlueTextFormField(
                        controller: bankNameEC,
                        isEnabled: false,
                        textInputAction: TextInputAction.next,
                        focusNode: bankNameFN,
                        hintText: "Select a bank",
                        suffixIcon: FaIcon(
                          FontAwesomeIcons.chevronDown,
                          size: 20,
                          color: kAccentColor,
                        ),
                        textInputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Select a bank";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          bankNameEC.text = value!;
                        },
                      ),
                    ),
                    kSizedBox,
                    Text(
                      'Account Number',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    MyTextFormField(
                      controller: accountNumberEC,
                      focusNode: accountNumberFN,
                      hintText: "Enter the account number here",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value!.isEmpty) {
                          accountNumberFN.requestFocus();
                          return "Enter the account number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        accountNumberEC.text = value!;
                      },
                    ),
                    kSizedBox,
                    Visibility(
                      visible: false,
                      child: Text(
                        'Blessing Mesoma',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
