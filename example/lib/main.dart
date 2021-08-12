import 'package:flutter/material.dart';
import 'package:time_overlapping/time_overlapping.dart';

void main() {
  final range1 = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(hours: 2)),
  );

  final range2 = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(hours: 1)),
  );

  final range3 = DateTimeRange(
    start: DateTime.now().add(const Duration(hours: 2)),
    end: DateTime.now().add(const Duration(hours: 3)),
  );

  final range4 = DateTimeRange(
    start: DateTime.now().add(const Duration(hours: 3)),
    end: DateTime.now().add(const Duration(hours: 4)),
  );

  final overlapParams = [
    OverlapParams('001', range1, {}),
    OverlapParams('002', range2, {}),
    OverlapParams('003', range3, {}),
    OverlapParams('004', range4, {}),
  ];

  print(TimeOverlapFinder.findOverlap(overlapParams));
  print(TimeOverlapFinder.findOverlapWithData(overlapParams));
}
