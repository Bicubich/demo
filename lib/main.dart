import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'features/order/controller/order_controller.dart';
import 'features/order/data/order_repository.dart';
import 'features/order/ui/order_screen.dart';

void main() {
  final apiClient = ApiClient(baseUrl: 'https://example.com');

  final repository = OrderRepository(apiClient: apiClient);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final OrderRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderController(repository: repository),
      child: const MaterialApp(home: OrderScreen()),
    );
  }
}
