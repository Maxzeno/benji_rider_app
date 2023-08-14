import 'package:benji_rider/app/withdrawal/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../theme/colors.dart';
import 'add_bank_account.dart';

class SelectAccountPage extends StatefulWidget {
  const SelectAccountPage({Key? key}) : super(key: key);

  @override
  State<SelectAccountPage> createState() => _SelectAccountPageState();
}

class _SelectAccountPageState extends State<SelectAccountPage> {
//===================================== ALL =========================================\\

  void _goToWithdraw() {
    Get.to(
      () => const WithdrawPage(),
      routeName: 'WithdrawPage',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: kPrimaryColor,
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
                  "Select Account",
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
        child: Column(
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: _goToWithdraw,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          // offset: Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/accessbank.png'),
                                kHalfWidthSizedBox,
                                Text(
                                  'Access Bank',
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _showBottomSheet(context);
                              },
                              icon: Icon(
                                Icons.more_horiz,
                                color: kAccentColor,
                              ),
                            )
                          ],
                        ),
                        kSizedBox,
                        Text(
                          'Blessing George....09876',
                          style: TextStyle(
                            color: Color(0xFF131514),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            kHalfSizedBox,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFFEF8F8),
                      minimumSize: Size(double.infinity, 60)),
                  onPressed: () {
                    Get.to(
                      () => AddBankAccountPage(),
                      routeName: 'AddBankAccountPage',
                      duration: const Duration(milliseconds: 300),
                      fullscreenDialog: true,
                      curve: Curves.easeIn,
                      preventDuplicates: true,
                      popGesture: true,
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Text(
                    'Add a new Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.only(left: 100, right: 100, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever,
                          color: kTextGreyColor,
                        ),
                        kWidthSizedBox,
                        Text(
                          'Delete account',
                          style: TextStyle(
                            color: Color(0xFF131514),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  kSizedBox,
                  Divider(),
                ],
              )),
        );
      },
    );
  }
}
