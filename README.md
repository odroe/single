# Single

Singleton mode container to store global singleton resources.

## Installation

- Dart: `dart pub add single`
- Flutter: `flutter pub add single`

## Usage

```dart
import 'package:single/single.dart';

// Add singleton resources
single + () => MyClass();

// Get singleton resources
MyClass myClass = single<MyClass>();
```

## Readmap

- [x] Singleton mode container.
- [x] `+` operator to add singleton resources.
- [x] Callable to get singleton resources.
- [ ] Use annotations to automatically register singletons.

> `Use annotations to automatically register singletons.` Need to learn more about related technologies:
> - `source_gen`? - But this method is not elegant
> - `dart:mirrors`? - This is ideal, but Flutter does not support it! Whether Single really needs to be used in Flutter is still uncertain. We currently use it on the Dart server.

## License

BSD 3-Clause License.
Copyright (c) 2021, [Odroe Inc.](https://odroe.com) All rights reserved.
