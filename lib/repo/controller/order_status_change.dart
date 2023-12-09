// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/order_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/delivery_model.dart';
import 'package:benji_rider/repo/models/order_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderStatusChangeController extends GetxController {
  static OrderStatusChangeController get instance {
    return Get.find<OrderStatusChangeController>();
  }

  var isLoad = false.obs;

  var order = Order.fromJson(null).obs;
  var task = DeliveryModel.fromJson(null).obs;

  Future setOrder(DeliveryModel deliveryObj) async {
    order.value = deliveryObj.order;
    task.value = deliveryObj;
    update();
    refreshOrder();
  }

  deleteCachedOrder() {
    order.value = Order.fromJson(null);
    update();
  }

  resetOrder() async {
    order.value = Order.fromJson(null);
    update();
  }

  Future refreshOrder() async {
    var url = "${Api.baseUrl}/orders/order/${order.value.id}";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    print(response?.body);
    print(response?.statusCode);
    OrderController.instance.getOrdersByStatus();

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      order.value = Order.fromJson(jsonDecode(responseData));
    } catch (e) {
      print('error in order change status controller to refresh order $e');
    }
    isLoad.value = false;
    update();
  }

  orderDispatched() async {
    isLoad.value = true;
    update();

    var url =
        "${Api.baseUrl}/orders/RiderToVendorChangeStatus?order_id=${order.value.id}";
    await FormController.instance.getAuth(url, 'dispatchOrder');
    print(FormController.instance.status);

    if (FormController.instance.status.toString().startsWith('2')) {}
    await refreshOrder();
  }

  orderDelivered() async {
    isLoad.value = true;
    final user = UserController.instance.user.value;

    update();
    var url =
        "${Api.baseUrl}/orders/RiderToUserChangeStatus?order_id=${order.value.id}";

    // var url2 =
    //     "${Api.baseUrl}/drivers/completeMyTask/${task.value.id}/${user.id}";

    await FormController.instance.getAuth(url, 'deliveredOrder');
    // await FormController.instance.getAuth(url2, 'deliveredOrder');
    print(FormController.instance.status);
    if (FormController.instance.status.toString().startsWith('2')) {}
    await refreshOrder();
  }
}
