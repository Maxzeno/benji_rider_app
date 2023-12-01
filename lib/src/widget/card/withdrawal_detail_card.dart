import 'package:flutter/material.dart';

import '../../../repo/models/withdrawal_history_model.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class WithdrawalDetailCard extends StatelessWidget {
  const WithdrawalDetailCard({
    super.key,
    required this.withdrawalDetail,
  });

  final WithdrawalHistoryModel withdrawalDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.shade400,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₦ ${intFormattedText(withdrawalDetail.amountWithdrawn)}',
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 16,
                  fontFamily: 'sen',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                withdrawalDetail.created,
                style: TextStyle(
                  color: kTextGreyColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          kSizedBox,
          Text(
            '${withdrawalDetail.bankName} ${withdrawalDetail.bankAccountNumber}',
            style: const TextStyle(
              color: kTextBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
