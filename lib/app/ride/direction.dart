import 'package:benji_rider/repo/models/delivery_model.dart';
import 'package:benji_rider/src/providers/constants.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:benji_rider/theme/colors.dart';
import 'package:flutter/material.dart';

class DirectsPage extends StatefulWidget {
  final DeliveryModel task;
  const DirectsPage({super.key, required this.task});

  @override
  State<DirectsPage> createState() => _DirectsPageState();
}

class _DirectsPageState extends State<DirectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: "Items",
        elevation: 10.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Items',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              kSizedBox,
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.task.order.orderitems.length,
                separatorBuilder: (BuildContext context, int index) {
                  return kHalfSizedBox;
                },
                itemBuilder: (BuildContext context, int indexItem) {
                  return Text(
                      '${widget.task.order.orderitems[indexItem].quantity}x ${widget.task.order.orderitems[indexItem].product.name}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
