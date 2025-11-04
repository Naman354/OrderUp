import '../entities/order_entity.dart';

abstract class OrderRepository {
  Stream<List<OrderEntity>> getOrdersStream();
}
