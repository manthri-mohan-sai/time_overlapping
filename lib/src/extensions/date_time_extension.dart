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

  /// [isCrossing] will help whether this timerange is crossing other or not.
  /// Either it can start or end. it will return bool.
  // 1.
  // |-- A --|
  //        |-- B --|
  // 2.
  //        |-- A --|
  // |-- B --|
  bool isCrossing(DateTimeRange other) {
    return isCrossingStart(other) || isCrossingEnd(other);
  }

  /// [isCrossingStart] will help whether this timeRange is crossing other timerange start or not.
  // Eg:
  //|-- A --|
  //       |-- B --|
  bool isCrossingStart(DateTimeRange other) {
    return end.isBefore(other.start) || start.isBefore(other.start);
  }

  /// [isCrossingEnd] will help whether this timeRange crossing other timerange end or not.
  // Eg:
  // |-- B --|
  //        |-- A --|
  bool isCrossingEnd(DateTimeRange other) {
    return start.isAfter(other.end) || end.isAfter(other.end);
  }

  /// Makes both start & end of a timeRange `seconds` `millisecond` `microsecond` to `0`
  DateTimeRange maskSeconds() {
    return DateTimeRange(
        start: DateTime(
          start.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
        ),
        end: DateTime(
          end.year,
          end.month,
          end.day,
          end.hour,
          end.minute,
        ));
  }

  /// Makes both start & end of a timeRange  `millisecond` `microsecond` to `0`
  DateTimeRange maskMilliSeconds() {
    return DateTimeRange(
        start: DateTime(
          start.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
        ),
        end: DateTime(
          end.year,
          end.month,
          end.day,
          end.hour,
          end.minute,
          end.second,
        ));
  }
}
