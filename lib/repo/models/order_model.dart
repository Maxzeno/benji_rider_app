import 'dart:convert';

import 'package:benji_rider/repo/models/address_model.dart';
import 'package:benji_rider/repo/models/client_model.dart';
import 'package:benji_rider/repo/models/product_model.dart';
import 'package:benji_rider/repo/models/user_model.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Order {
  String id;
  String code;
  double totalPrice;
  String latitude;
  String longtitude;
  double deliveryFee;
  String assignedStatus;
  String deliveryStatus;
  Client client;
  List<OrderItem> orderitems;
  Address deliveryAddress;
  String created;

  Order({
    required this.id,
    required this.code,
    required this.totalPrice,
    required this.latitude,
    required this.longtitude,
    required this.deliveryFee,
    required this.assignedStatus,
    required this.deliveryStatus,
    required this.client,
    required this.orderitems,
    required this.created,
    required this.deliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Order(
      id: json["id"] ?? notAvailable,
      code: json["code"] ?? notAvailable,
      latitude: json["latitude"] ?? '',
      longtitude: json["longtitude"] ?? '',
      totalPrice: json["total_price"] ?? 0.0,
      deliveryFee: json["delivery_fee"] ?? 0.0,
      assignedStatus: json["assigned_status"] ?? "PEND",
      deliveryStatus: json["delivery_status"] ?? "pending",
      client: Client.fromJson(json["client"]),
      orderitems: json["orderitems"] == null
          ? []
          : (json["orderitems"] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList(),
      created: json["created"] ?? notAvailable,
      deliveryAddress: Address.fromJson(json["delivery_address"]),
    );
  }
}

class OrderItem {
  String id;
  ProductModel product;
  int quantity;
  Address deliveryAddress;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.deliveryAddress,
  });

  factory OrderItem.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return OrderItem(
      id: json["id"] ?? notAvailable,
      product: ProductModel.fromJson(json["product"]),
      deliveryAddress: Address.fromJson(json["delivery_address"]),
      quantity: json["quantity"] ?? 0,
    );
  }
}

Future<List<Order>> fetchOrdersByDriver() async {
  User? user = await getUser();
  final response = await http
      .get(Uri.parse('$baseURL/drivers/commissionEarned/${user!.id}'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((item) => Order.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
