import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OverlapParams extends Equatable {
  OverlapParams(this.id, this.dateTimeRange, this.data);

  final dynamic data;
  final DateTimeRange dateTimeRange;
  final String id;

  @override
  List<Object?> get props => [id, dateTimeRange, data];
}
