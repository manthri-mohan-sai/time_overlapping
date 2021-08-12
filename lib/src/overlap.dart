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
  static List<String> findOverlap(List<OverlapParams> overlapParams) {
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
    } catch (e) {
      return <String>[];
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
    List<OverlapParams> overlapParams,
  ) {
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
    } catch (e) {
      return <OverlapParams>[];
    }
  }

  static bool hasOverlap(DateTimeRange range1, DateTimeRange range2) {
    return !(range2.isBefore(range1) || range2.isAfter(range1));
  }

  static List<T> _calculateOverlapRanges<T>(List<OverlapParams> ranges) {
    final overlapList = <T>{};

    /// [sort] all the ranges, so that we can easily find the overlapping.
    /// instead of dangling between indexes.
    ranges
        .sort((a, b) => a.dateTimeRange.start.compareTo(b.dateTimeRange.start));

    if (ranges.length == 2) {
      final hasTimeOverlap =
          hasOverlap(ranges.first.dateTimeRange, ranges.last.dateTimeRange);

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
