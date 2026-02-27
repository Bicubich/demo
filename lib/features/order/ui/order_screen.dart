import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/order_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Создание заказа')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.state == OrderState.loading)
                const CircularProgressIndicator(),

              if (controller.state == OrderState.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    controller.errorMessage ?? 'Ошибка',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (controller.state == OrderState.success)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Заказ №${controller.order?.orderId} создан',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: controller.state == OrderState.loading
                    ? null
                    : () {
                        controller.submitOrder(
                          userId: 1,
                          serviceId: 10,
                        );
                      },
                child: const Text('Создать заказ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
