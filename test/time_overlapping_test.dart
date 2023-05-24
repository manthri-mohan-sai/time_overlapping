import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

      expect(() => TimeOverlapFinder.findOverlap(overlapParams), throwsAssertionError);
      expect(() => TimeOverlapFinder.findOverlapWithData(overlapParams), throwsAssertionError);
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

    test('Testing ordered overlap ranges: 2', () {
      final range1 = DateTimeRange(
        start: DateTime(2021, 8, 12, 10, 00),
        end: DateTime(2021, 8, 12, 10, 10),
      );

      final range2 = DateTimeRange(
        start: DateTime(2021, 8, 12, 10, 00),
        end: DateTime(2021, 8, 12, 10, 20),
      );

      final range3 = DateTimeRange(
        start: DateTime(2021, 8, 12, 10, 00),
        end: DateTime(2021, 8, 12, 10, 15),
      );

      final overlapParams = [
        OverlapParams('001', range1, {}),
        OverlapParams('002', range2, {}),
        OverlapParams('003', range3, {}),
      ];
      expect(TimeOverlapFinder.findOverlap(overlapParams), ['001', '002', '003']);
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
        '0012',
        '0011',
      ]);
    });

    test('Testing single dateTimeRange', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {}),
      ];

      expect(TimeOverlapFinder.findOverlap(overlapParams), <String>[]);
    });

    test('Testing single dateTimeRange with data', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {'name': 'userA'}),
      ];

      expect(TimeOverlapFinder.findOverlapWithData(overlapParams), <String>[]);
    });

    test('Testing hasOverlap method: 1', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );
      expect(TimeOverlapFinder.hasOverlap(range1, range2), false);
    });

    test('Testing findOverlap  for 2 items without overlapping', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {'name': 'userA'}),
        OverlapParams('002', range2, {'name': 'userB'}),
      ];

      expect(TimeOverlapFinder.findOverlap(overlapParams), []);
    });

    test('Testing findOverlap  for 2 items with overlapping', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
      );

      final overlapParams = [
        OverlapParams('001', range1, {'name': 'userA'}),
        OverlapParams('002', range2, {'name': 'userB'}),
      ];

      expect(TimeOverlapFinder.findOverlap(overlapParams), ['001', '002']);
    });

    test('Testing hasOverlap method: 2', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(TimeOverlapFinder.hasOverlap(range1, range2), true);
    });

    test('Testing Allow touches: Allow touches `False`', () {
      final _commonTime = DateTime.now().add(const Duration(hours: 2));
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: _commonTime,
      );

      final range2 = DateTimeRange(
        start: _commonTime,
        end: _commonTime.add(const Duration(hours: 1)),
      );
      print(range1);
      print(range2);
      expect(TimeOverlapFinder.hasOverlap(range1, range2, allowTouches: false), true);
    });

    test('Testing Allow touches: Allow touches `True`', () {
      final _commonTime = DateTime.now().add(const Duration(hours: 2));
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: _commonTime,
      );

      final range2 = DateTimeRange(
        start: _commonTime,
        end: _commonTime.add(const Duration(hours: 1)),
      );
      print(range1);
      print(range2);
      expect(TimeOverlapFinder.hasOverlap(range1, range2, allowTouches: true), false);
    });

    test('Testing Allow touches: Allow touches False Ignore Seconds: False', () {
      final _commonTime = DateTime.now().add(const Duration(hours: 2));
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: _commonTime,
      );

      final range2 = DateTimeRange(
        start: _commonTime,
        end: _commonTime.add(const Duration(hours: 1)),
      );
      print(range1);
      print(range2);
      expect(
          TimeOverlapFinder.hasOverlap(
            range1,
            range2,
            allowTouches: false,
            ignoreSeconds: false,
          ),
          true);
    });

    test('Testing Allow touches: Allow touches False Ignore Seconds: True', () {
      final range1 = DateTimeRange(start: DateTime(2023, 05, 18), end: DateTime(2023, 05, 18, 17));
      final range2 = DateTimeRange(
        start: DateTime(2023, 05, 18, 17, 0, 0, 299),
        end: DateTime(2023, 05, 18, 19, 0, 0, 299),
      );
      final range3 = DateTimeRange(start: DateTime(2023, 05, 18, 19), end: DateTime(2023, 05, 18, 23, 59));
      print(range1);
      print(range2);
      print(range3);
      expect(
        TimeOverlapFinder.hasOverlap(
          range1,
          range2,
          allowTouches: false,
          ignoreSeconds: true,
        ),
        true,
      );
    });

    test('Testing Allow touches: Allow touches True Ignore Seconds: True', () {
      final range1 = DateTimeRange(start: DateTime(2023, 05, 18), end: DateTime(2023, 05, 18, 17));
      final range2 = DateTimeRange(
        start: DateTime(2023, 05, 18, 17, 0, 0, 299),
        end: DateTime(2023, 05, 18, 19, 0, 0, 299),
      );
      final range3 = DateTimeRange(start: DateTime(2023, 05, 18, 19), end: DateTime(2023, 05, 18, 23, 59));
      print(range1);
      print(range2);
      print(range3);
      expect(
        TimeOverlapFinder.hasOverlap(
          range1,
          range2,
          allowTouches: true,
          ignoreSeconds: true,
        ),
        false,
      );
    });

    test('Testing isCrossing function', () {
      final range1 = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
      );

      final range2 = DateTimeRange(
        start: DateTime.now().add(const Duration(hours: 1, minutes: 30)),
        end: DateTime.now().add(const Duration(hours: 3)),
      );

      expect(range2.isCrossing(range1), true);
      expect(range1.isCrossing(range2), true);
      expect(range1.isCrossingStart(range2), true);
      expect(range2.isCrossingStart(range1), false);
      expect(range2.isCrossingEnd(range1), true);
      expect(range1.isCrossingEnd(range2), false);
    });
  });
}
