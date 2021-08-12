import 'package:flutter/material.dart';

extension DateTimeRangeExtensions on DateTimeRange {
  /// [isAfter] returns whether the timeRange is after other timeRange or not.
  //
  // |-- A --|
  //         |-- B --|
  //
  bool isAfter(DateTimeRange other) {
    final otherRangeStart = other.start;
    final pointInRange = otherRangeStart.isAtSameMomentAs(end);
    final isAfterRange = otherRangeStart.isAfter(end);
    final isNotBeforeRange = !otherRangeStart.isBefore(end);
    return (pointInRange || isAfterRange) && isNotBeforeRange;
  }

  /// [isBefore] returns whether the timeRange is before than other timeRange.
  //
  // |-- B --|
  //         |-- A --|
  //
  bool isBefore(DateTimeRange other) {
    final otherRangeEnd = other.end;
    final pointInRange = otherRangeEnd.isAtSameMomentAs(start);
    final isBeforeRange = otherRangeEnd.isBefore(start);
    final isNotAfterRange = !otherRangeEnd.isAfter(start);
    return (pointInRange || isBeforeRange) && isNotAfterRange;
  }
}
