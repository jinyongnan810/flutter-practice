### Iterate n times

```dart
// gets item0, item1, item2, item3, item4
Iterable.generate(5, (i) => 'item$i').toList();
```

### Shuffle the list and return

```dart
List<int> list = [1, 2, 3, 4, 5];
// shuffle returns void, so to get the list after shuffle, we need to use ..
print(list..shuffle());
```

### Expand iterables

```dart
List<String> getStrings(String type) {
  switch (type) {
    case 'a':
      return ['a1', 'a2', 'a3'];
    case 'b':
      return ['b1', 'b2'];
    default:
      return ['d1', 'd2', 'd3', 'd4'];
  }
}
// gets [a1, a2, a3, b1, b2, a1, a2, a3, d1, d2, d3, d4]
print(['a', 'b', 'a', 'eee'].expand(getStrings).toList());
```

### Make a long string

```dart
// makes abcdefghij
String str = 'abc'
      'def'
      'ghij';
```
