# time_overlapping

TimeOverlapping package is a lightweight and blazing fast for checking the time overlapping in the given DateTime ranges.

[![codecov](https://codecov.io/gh/MohanSaiManthri/time_overlapping/branch/main/graph/badge.svg?token=CHD4N0WLZM)](https://codecov.io/gh/MohanSaiManthri/time_overlapping)
[![Dart](https://github.com/MohanSaiManthri/time_overlapping/actions/workflows/dart.yml/badge.svg)](https://github.com/MohanSaiManthri/time_overlapping/actions/workflows/dart.yml)
[![pub.dev](https://img.shields.io/pub/v/time_overlapping?label=pub.dev&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAQAAAC1QeVaAAAABGdBTUEAALGPC%2FxhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA%2F4ePzL8AAAAHdElNRQflCAwFLhzpNkNgAAAAAW9yTlQBz6J3mgAAATFJREFUGNNN0M0qhGEYh%2FHrft73NaZoImNKkYUFCxt7KdYWFiymKKfgCBTHYMshWFkppVijJp81skBMM9P4SN557r8FC9f2t7sM4IN3SqhgUwxYSxe4KAIBvskoo7JN63XryN7C1JdF2oB1KOAhmWMoXNkHhuKkXxbqOQETEBdsyWatjAMo93PbC%2FsRuuQVP1bVV9XWX37vj7Gaw435tlzLwtfV%2BsMnb6rha3QX9SrXivjHn16X4kGweYYQgGO7bNAGiji5EbSjQwIShsOufrlPHSPZbPqJVfyhXft0A5Izvdic9dPUc7KJtb4PvJykaZ9lMRLTM70wQ4%2FdWYNBclTxse510ks%2FkQ5ZthbeODKoMUEXjYSRUEtjXlSJHhvuPY3Y7%2FgOJTSajofoCDI92m3ODyeBsv3LZ4DoAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIxLTA4LTEyVDA1OjQ2OjI4KzAwOjAwwzEIWwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMS0wOC0xMlQwNTo0NjoyOCswMDowMLJssOcAAAAASUVORK5CYII%3D&logoColor=green)](https://pub.dartlang.org/packages/time_overlapping)
[![license](https://img.shields.io/github/license/MohanSaiManthri/time_overlapping?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQEAQAAADlauupAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAABgAAAAYADwa0LPAAAAB3RJTUUH5QgMBTIvsJF/KwAAAAJiS0dEAACqjSMyAAAA6klEQVQ4y53TrwrCUBTH8cWNJatgVJF1weCf4DuIQebqlowKewqD2YcQ38GwB9jAIJoMrk1Qzle2C4rN469/zrnncK5l/RGwbeh0rP/wcAhZBiLqIhBF8HxSJU3LlyhwHIPvw+0GjwfS7yvwaoXMZnA8QhBAGP6OK1gmzw2OY0XnXg+KgneWSwWu1+F8NvB+h/lcgR0HDofKyvWKDAaKmVstWCwMThKk0VB0nk7N0jYbU8R1f4TtNux2sN3Cel1tW5pNxbyn02fTZZHJRDFzt8tX9nvlfY9GH3y5gOcpC9RqyHhsjsZxtL/zBX3z7zeyXyFwAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIxLTA4LTEyVDA1OjUwOjQ3KzAwOjAwP4besgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMS0wOC0xMlQwNTo1MDo0NyswMDowME7bZg4AAAAASUVORK5CYII=)](https://github.com/MohanSaiManthri/time_overlapping/blob/main/LICENSE)

## Getting Started

This package accepts only `List<OverlapParams>` 

#### OverlapParams
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
##### Output
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
##### Output
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

##### Output
```dart
true
```

#### Some useful extensions

```dart
1. range1.isBefore(range2),
2. range1.isAfter(range2),
```

```dart
1. range1.isCrossing(range2),
2. range1.isCrossingStart(range2),
3. range1.isCrossingEnd(range2),
```

### Thanks for using my package 🙏
