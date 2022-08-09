import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category(this.id, this.name, this.color);
  final String id;
  final String name;
  final String color;

  @override
  List<Object> get props => [id, name, color];
}
