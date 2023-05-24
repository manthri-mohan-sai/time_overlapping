import 'package:flutter/material.dart';
import 'package:time_overlapping/time_overlapping.dart';

class TimeOverlapFinder {
  const TimeOverlapFinder._internal();

  /// returns all the overlapping Id's ie.., `List<String>`.
  ///
  /// If data is required then use
  /// ```dart
  /// TimeOverlapFinder.findOverlapWithData(overlapParams);
  /// ```
  /// ...
  static List<String> findOverlap(
    List<OverlapParams> overlapParams, {
    bool allowTouches = true,
    bool ignoreSeconds = true,
  }) {
    try {
      if (overlapParams.length < 2) {
        return <String>[];
      }
      assert(
        _validEntries(overlapParams),
        "There should be exactly one item with [OverlapParams]'s id.\n"
        'Either zero or 2 or more [OverlapParams]s were detected '
        'with the same value',
      );
      return _calculateOverlapRanges<String>(overlapParams);
    } on AssertionError catch (_) {
      rethrow;
    }
  }

  /// returns `List<OverlapParams>`
  /// This can be used if data needs to returned, so that it can be used
  /// for some purpose.
  ///
  /// If data is not required then use
  /// ```dart
  /// TimeOverlapFinder.findOverlap(overlapParams);
  /// ```
  /// ...
  static List<OverlapParams> findOverlapWithData(
    List<OverlapParams> overlapParams, {
    bool allowTouches = true,
    bool ignoreSeconds = true,
  }) {
    try {
      if (overlapParams.length < 2) {
        return <OverlapParams>[];
      }
      assert(
        _validEntries(overlapParams),
        "There should be exactly one item with [OverlapParams]'s id.\n"
        'Either zero or 2 or more [OverlapParams]s were detected '
        'with the same value',
      );
      return _calculateOverlapRanges<OverlapParams>(overlapParams);
    } on AssertionError catch (_) {
      rethrow;
    }
  }

  /// `allowTouches` defaults to true thus ignore any start, end overlapping
  /// Eg:
  /// ```dart
  /// 2022-03-12 11:47 - 2022-03-12 13:47
  /// 2022-03-12 13:47 - 2022-03-12 14:47
  /// ```
  ///
  /// `allowTouches: true` will return hasOverlap false;
  /// `false` will return hasOverlap true;
  ///
  ///
  /// ```dart
  /// if ignoreSeconds: true
  /// ```
  /// will makes seconds to `0` thus comparing
  /// only date, hour and minutes.
  ///
  static bool hasOverlap(
    DateTimeRange range1,
    DateTimeRange range2, {
    bool allowTouches = true,
    bool ignoreSeconds = true,
  }) {
    bool _hasOverlap = !(range2.isBefore(range1) || range2.isAfter(range1));
    if (allowTouches) return _hasOverlap;
    return hasTouch(range1, range2, ignoreSeconds: ignoreSeconds);
  }

  /// Checks the range has any touches at start or end
  /// Default: Ranges start and end's milliseconds will make `0` before comparing
  /// ```dart
  /// if ignoreSeconds: true
  /// ```
  /// will makes seconds to `0` thus comparing
  /// only date, hour and minutes.
  ///
  static bool hasTouch(
    DateTimeRange range,
    DateTimeRange other, {
    bool ignoreSeconds = false,
  }) {
    final maskedRange =
        ignoreSeconds ? range.maskSeconds() : range.maskMilliSeconds();
    final maskedOther =
        ignoreSeconds ? other.maskSeconds() : other.maskMilliSeconds();
    return maskedRange.start.isAtSameMomentAs(maskedOther.start) ||
        maskedRange.end.isAtSameMomentAs(maskedOther.start) ||
        maskedRange.start.isAtSameMomentAs(maskedOther.end) ||
        maskedRange.end.isAtSameMomentAs(maskedOther.end);
  }

  static List<T> _calculateOverlapRanges<T>(
    List<OverlapParams> ranges, {
    bool allowTouches = true,
    bool ignoreSeconds = true,
  }) {
    final overlapList = <T>{};

    /// [sort] all the ranges, so that we can easily find the overlapping.
    /// instead of dangling between indexes.
    ranges
        .sort((a, b) => a.dateTimeRange.start.compareTo(b.dateTimeRange.start));

    if (ranges.length == 2) {
      final hasTimeOverlap = hasOverlap(
        ranges.first.dateTimeRange,
        ranges.last.dateTimeRange,
        allowTouches: allowTouches,
        ignoreSeconds: ignoreSeconds,
      );

      if (hasTimeOverlap) {
        if (T == String) {
          overlapList.add(ranges.first.id as T);
          overlapList.add(ranges.last.id as T);
          return overlapList.toList();
        } else if (T == OverlapParams) {
          return ranges as List<T>;
        }
      } else {
        return overlapList.toList();
      }
    }

    for (var i = 0; i < ranges.length - 1; i++) {
      /// [subIndex] is an integer which points to next index.
      var subIndex = i + 1;
      var rangeAtIndex = ranges.elementAt(i);
      var rangeAtFutureIndex = ranges.elementAt(i + 1);

      var isBefore =
          rangeAtIndex.dateTimeRange.isBefore(rangeAtFutureIndex.dateTimeRange);
      var isAfter =
          rangeAtIndex.dateTimeRange.isAfter(rangeAtFutureIndex.dateTimeRange);

      ///
      /// 1.
      /// |--- A ---|
      ///           | --- B ---|
      ///
      /// or
      ///
      /// 2.
      /// |--- B---|
      ///          |--- A ---|
      ///
      /// [1] & [2] are positive conditions and [NOT] of that is overlapping cond.
      ///
      ///
      /// This will iterate till the moment we dont have overlap with next
      /// dateTimeRange.
      while ((!(isBefore || isAfter)) && subIndex < ranges.length) {
        subIndex += 1;
        if (T == String) {
          overlapList.add(rangeAtIndex.id as T);
          overlapList.add(rangeAtFutureIndex.id as T);
        } else if (T == OverlapParams) {
          overlapList.add(rangeAtIndex as T);
          overlapList.add(rangeAtFutureIndex as T);
        }

        if (subIndex >= ranges.length - 1) {
          break;
        }

        rangeAtIndex = ranges.elementAt(i);
        rangeAtFutureIndex = ranges.elementAt(subIndex);

        isBefore = rangeAtIndex.dateTimeRange
            .isBefore(rangeAtFutureIndex.dateTimeRange);
        isAfter = rangeAtIndex.dateTimeRange
            .isAfter(rangeAtFutureIndex.dateTimeRange);
      }
    }
    return overlapList.toList();
  }

  static bool _validEntries(List<OverlapParams> overlapParams) {
    final listOfIds = overlapParams.fold<List<String>>([overlapParams.first.id],
        (previousValue, element) {
      if (previousValue.contains(element.id)) {
        return previousValue;
      } else {
        return [...previousValue, element.id];
      }
    });
    return listOfIds.length == overlapParams.length;
  }
}
