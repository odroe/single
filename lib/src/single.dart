// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part 'single.impl.dart';

/// Single object factory.
typedef SingleFactory<T extends Object> = T Function();

// Single abstract class.
abstract class Single {
  /// Get registed singleton factory.
  List<SingleFactory<Object>> get factories;

  /// Get a singleton.
  ///
  /// [T] The type of the singleton.
  T call<T extends Object>();

  /// Register a factory.
  ///
  /// [creator] The factory to create the singleton.
  void operator +(SingleFactory factory);
}

/// Singleton container.
///
/// This class is used to create lazy containers.
///
/// Example:
/// ```dart
/// // Register a singleton
/// single + () => MyClass();
///
/// // Find a singleton
/// final myClass = single<MyClass>();
/// ```
final Single single = _SingleImpl();
