enum OrderStatus {
  order_not_placed,
  order_placed,
  pending,
  received,
  canceled,
  collecting,
  collected,
  receive_delevary_boy,
  on_the_way,
  delivered,
}

extension normalize on OrderStatus {
  String get value {
    return this.toString().split('.').last;
  }
}
