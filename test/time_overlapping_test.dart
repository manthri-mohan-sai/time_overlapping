import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_overlapping/src/overlap.dart';

import 'package:time_overlapping/time_overlapping.dart';

void main() {
  group('Overlap Tests: ', () {
    test('Testing duplicate Id\'s', () {
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
        OverlapParams('001', range3, {}),
        OverlapParams('004', range4, {}),
      ];

      expect(() => TimeOverlapFinder.findOverlap(overlapParams),
          throwsAssertionError);
    });

    test('Testing ordered overlap ranges', () {
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
      expect(TimeOverlapFinder.findOverlap(overlapParams), ['001', '002']);
    });

    test('Testing unOrdered overlap ranges', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );

      final range3 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
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
      expect(TimeOverlapFinder.findOverlap(overlapParams), ['001', '003']);
    });

    test('Testing unOrdered overlap ranges with data', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );

      final range3 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
      );

      final range4 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 4)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {'name': 'userA'}),
        OverlapParams('002', range2, {'name': 'userB'}),
        OverlapParams('003', range3, {'name': 'userC'}),
        OverlapParams('004', range4, {'name': 'userD'}),
      ];
      expect(
        TimeOverlapFinder.findOverlapWithData(overlapParams),
        [
          OverlapParams('001', range1, {'name': 'userA'}),
          OverlapParams('003', range3, {'name': 'userC'}),
        ],
      );
    });

    test('Testing time complexity for long range', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );

      final range3 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
      );

      final range4 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 4)),
      );

      final range5 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 5)),
      );

      final range6 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 3, minutes: 30)),
      );

      final range7 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 5)),
        end: DateTime.now().add(const Duration(hours: 6)),
      );

      final range8 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 6)),
        end: DateTime.now().add(const Duration(hours: 9)),
      );

      final range9 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 6)),
        end: DateTime.now().add(const Duration(hours: 8)),
      );

      final range10 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 7)),
        end: DateTime.now().add(const Duration(hours: 8)),
      );

      final range11 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 9)),
        end: DateTime.now().add(const Duration(hours: 10)),
      );

      final range12 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 8)),
        end: DateTime.now().add(const Duration(hours: 10)),
      );

      final range13 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 10)),
        end: DateTime.now().add(const Duration(hours: 11)),
      );

      final range14 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 11)),
        end: DateTime.now().add(const Duration(hours: 12)),
      );

      final range15 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 12)),
        end: DateTime.now().add(const Duration(hours: 13)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {}),
        OverlapParams('002', range2, {}),
        OverlapParams('003', range3, {}),
        OverlapParams('004', range4, {}),
        OverlapParams('005', range5, {}),
        OverlapParams('006', range6, {}),
        OverlapParams('007', range7, {}),
        OverlapParams('008', range8, {}),
        OverlapParams('009', range9, {}),
        OverlapParams('0010', range10, {}),
        OverlapParams('0011', range11, {}),
        OverlapParams('0012', range12, {}),
        OverlapParams('0013', range13, {}),
        OverlapParams('0014', range14, {}),
        OverlapParams('0015', range15, {}),
      ];
      expect(TimeOverlapFinder.findOverlap(overlapParams), [
        '001',
        '003',
        '004',
        '005',
        '006',
        '008',
        '009',
        '0010',
        '0011',
        '0012'
      ]);
    });
  });
}
