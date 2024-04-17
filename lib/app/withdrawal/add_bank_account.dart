import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/account_controller.dart';
import '../../src/repo/controller/api_url.dart';
import '../../src/repo/controller/form_controller.dart';
import '../../src/repo/controller/user_controller.dart';
import '../../src/repo/controller/withdraw_controller.dart';
import '../../src/repo/models/validate_bank_account.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my_blue_textformfield.dart';
import '../../src/widget/form_and_auth/number_textformfield.dart';
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
    WithdrawController.instance.getBanks();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

//===================================== ALL VARIABLES =========================================\\

//===================================== BOOL VALUES =========================================\\
  bool isVisible = false;

//================= Controllers ==================\\
  final scrollController = ScrollController();
  final bankNameEC = TextEditingController();
  final accountNumberEC = TextEditingController();

//================= Focus Nodes ==================\\
  final bankNameFN = FocusNode();
  final bankNames = FocusNode();
  final accountNumberFN = FocusNode();

  final formKey = GlobalKey<FormState>();

  String bankCode = "";

  //================================== FUNCTION ====================================\\

  //=================================== Navigation ============================\\
  goToSelectBank() async {
    final result = await Get.to(
      () => const SelectBank(),
      routeName: 'SelectBank',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
    if (result != null) {
      final newBankName = result['name'];
      final newBankCode = result['code'];

      setState(() {
        bankNameEC.text = newBankName;
        bankCode = newBankCode;
      });
    }
    log("BankName: ${bankNameEC.text}, bankCode: $bankCode");
  }

  Future<void> handleRefresh() async {
    await WithdrawController.instance.getBanks();
  }

  saveAccount(ValidateBankAccountModel data) async {
    Map body = {
      'user_id': UserController.instance.user.value.id.toString(),
      'bank_name': bankNameEC.text,
      'bank_code': data.responseBody.bankCode,
      'account_holder': data.responseBody.accountName,
      'account_number': data.responseBody.accountNumber,
    };
    print(body);

    String url = Api.baseUrl + Api.saveBankDetails;
    await FormController.instance.postAuth(
      url,
      body,
      'saveBankDetails',
      'An error occured, please try again later',
      'Added successfully',
      false,
    );

    if (FormController.instance.status.value == 200) {
      log("This is the status code for saving the account details: ${FormController.instance.status.value.toString()}");
      await AccountController.instance.refreshBankAccountsData();
      Get.close(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Add bank account",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        bottomNavigationBar: GetBuilder<WithdrawController>(
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: kAccentColor.withOpacity(0.08),
                  offset: const Offset(3, 0),
                  blurRadius: 32,
                ),
              ]),
              child: Obx(
                () => MyElevatedButton(
                  title: "Save Account",
                  onPressed: !controller
                              .validateAccount.value.requestSuccessful ||
                          accountNumberEC.text.length < 10
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            await saveAccount(controller.validateAccount.value);
                          }
                        },
                  isLoading: FormController.instance.isLoad.value,
                ),
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<WithdrawController>(
              init: WithdrawController(),
              initState: (state) => WithdrawController.instance.getBanks(),
              builder: (controller) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        onTap: controller.listOfBanks.isEmpty ||
                                controller.isLoad.value
                            ? null
                            : goToSelectBank,
                        child: MyBlueTextFormField(
                          controller: bankNameEC,
                          isEnabled: false,
                          textInputAction: TextInputAction.next,
                          focusNode: bankNameFN,
                          hintText: controller.listOfBanks.isEmpty ||
                                  controller.isLoad.value
                              ? "Loading..."
                              : "Select a bank",
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
                            setState(() {
                              bankNameEC.text = value!;
                            });
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
                      NumberTextFormField(
                        controller: accountNumberEC,
                        focusNode: accountNumberFN,
                        hintText: "Enter the account number here",
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxlength: 11,
                        onChanged: (value) {
                          if (value.length >= 10 ||
                              accountNumberEC.text.length >= 10) {
                            WithdrawController.instance.validateBankNumbers(
                              accountNumberEC.text,
                              bankCode,
                            );
                          }
                          setState(() {});
                        },
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
                      () {
                        if (accountNumberEC.text.length < 10) {
                          return const Text("");
                        }
                        if (controller.isLoadValidateAccount.value) {
                          log(
                            controller.validateAccount.value.requestSuccessful
                                ? controller.validateAccount.value.responseBody
                                    .accountName
                                : 'Invalid account number',
                          );
                          return Text(
                            'Loading...',
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: media.width - 100,
                            child: Text(
                              controller.validateAccount.value.requestSuccessful
                                  ? controller.validateAccount.value
                                      .responseBody.accountName
                                  : 'Invalid account number',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: controller
                                        .validateAccount.value.requestSuccessful
                                    ? kSuccessColor
                                    : kAccentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                      }(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
