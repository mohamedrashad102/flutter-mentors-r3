import 'package:equatable/equatable.dart';

import 'coffee_types/coffee.dart';

enum OrderStatus {
  pending('Pending'),
  completed('Completed');

  const OrderStatus(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}

class Order extends Equatable {
  final int _id;
  final String _customerName;
  final Coffee _coffee;
  final OrderStatus _status;
  final DateTime _createdAt;
  final String? _notes;

  const Order({
    required int id,
    required String customerName,
    required Coffee coffee,
    required OrderStatus status,
    required DateTime createdAt,
    String? notes,
  }) : _createdAt = createdAt,
       _status = status,
       _coffee = coffee,
       _customerName = customerName,
       _id = id,
       _notes = notes;

  int get id => _id;

  String get customerName => _customerName;

  Coffee get coffee => _coffee;

  OrderStatus get status => _status;

  DateTime get createdAt => _createdAt;

  String? get notes => _notes;

  Order copyWith({
    int? id,
    String? customerName,
    Coffee? coffee,
    OrderStatus? status,
    DateTime? createdAt,
    String? notes,
  }) {
    return Order(
      id: id ?? _id,
      customerName: customerName ?? _customerName,
      coffee: coffee ?? _coffee,
      status: status ?? _status,
      createdAt: createdAt ?? _createdAt,
      notes: notes ?? _notes,
    );
  }

  @override
  List<Object?> get props => [_id, _customerName, _coffee, _status, _createdAt, _notes];
}
