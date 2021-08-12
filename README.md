# time_overlapping

TimeOverlapping package is a lightweight and blazing fast for checking the time overlapping in the given DateTime ranges.


## Getting Started

This package accepts only `List<OverlapParams>` 

####OverlapParams
This requires an uniqueId, DateTimeRange & dynamic data*.
> dynamic data is type **dynamic** which accepts any sort of data.

It will throw **AssertionError** if it founds any duplicate Ids.
```dart
OverlapParams('uniqueId', DateTimeRange(start, end), {}),
```

There are 3 type of functions to find overlapping.
1. **findOverlap**  - returns the `List<String>` ie.., list of overlapping Ids.
2. **findOverlapWithData** - returns the `List<OverlapParams>` which has DateTimeRange overlap.
3. **hasOverlap** - to find timeOverlap for only 2 dateTimeRange. - returns bool.

## Usage
### findOverlap

```dart
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
}
```
#####Output
```dart
['001', '002']
```

### findOverlapWithData

```dart
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

  print(TimeOverlapFinder.findOverlapWithData(overlapParams));
}
```
#####Output
```dart
 [
    OverlapParams(001, 2021-08-12 07:36:07.095 - 2021-08-12 09:36:07.095, {}),
    OverlapParams(002, 2021-08-12 07:36:07.095 - 2021-08-12 08:36:07.095, {})
 ]
```

### hasOverlap

```dart
void main() {
  final range1 = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(hours: 2)),
  );

  final range2 = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(hours: 1)),
  );

  final overlapParams = [
    OverlapParams('001', range1, {}),
    OverlapParams('002', range2, {}),
  ];

  print(TimeOverlapFinder.hasOverlap(range1, range2));
}
```

#####Output
```dart
true
```

### Thanks for using my package 🙏
