import 'package:flutter/material.dart';

import '../data/order_repository.dart';
import '../models/order.dart';

enum OrderState {
  initial,
  loading,
  success,
  error,
}

class OrderController extends ChangeNotifier {
  final OrderRepository repository;

  OrderController({required this.repository});

  OrderState state = OrderState.initial;
  String? errorMessage;
  Order? order;

  Future<void> submitOrder({
    required int userId,
    required int serviceId,
  }) async {
    state = OrderState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.createOrder(
        userId: userId,
        serviceId: serviceId,
      );

      order = result;
      state = OrderState.success;
    } catch (e) {
      state = OrderState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
