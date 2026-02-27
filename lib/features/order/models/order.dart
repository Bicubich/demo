class Order {
  final int orderId;
  final String status;
  final String? paymentUrl;

  Order({
    required this.orderId,
    required this.status,
    required this.paymentUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] as int,
      status: json['status'] as String,
      paymentUrl: json['payment_url'] as String?,
    );
  }
}
