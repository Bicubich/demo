import '../../../core/network/api_client.dart';
import '../models/order.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository({required this.apiClient});

  Future<Order> createOrder({
    required int userId,
    required int serviceId,
  }) async {
    final json = await apiClient.post(
      '/api/orders',
      {
        'userId': userId,
        'serviceId': serviceId,
      },
    );

    return Order.fromJson(json);
  }
}
