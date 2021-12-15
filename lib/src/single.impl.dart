// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of 'single.dart';

class _SingleImpl extends Single {
  _SingleImpl() {
    _register<Single>(() => this);
  }

  final Map<Type, Object> singletons = {};
  final List<SingleFactory> factories = [];
  final List<SingleFinder> finders = [];

  @override
  void operator |(SingleFinder finder) {
    finders.removeWhere((element) => element.runtimeType == finder.runtimeType);
    finders.add(finder);
  }

  @override
  void operator +(SingleFactory factory) => _register(factory);

  @override
  T call<T extends Object>() => _find<T>();

  void _register<T extends Object>(SingleFactory<T> factory) {
    if (factories
        .any((element) => element.runtimeType == factory.runtimeType)) {
      throw Exception('Factory of type $T has been registered');
    }

    factories.add(factory);
  }

  T _find<T extends Object>() {
    if (singletons.containsKey(T)) {
      return singletons[T] as T;
    }

    if (factories.any((element) => element.runtimeType == SingleFactory<T>)) {
      final SingleFactory<T> factory =
          factories.whereType<SingleFactory<T>>().single;
      return singletons[factory.runtimeType] = factory();
    }

    for (final finder in finders) {
      final SingleFactory<T>? factory = finder<T>();
      if (factory is SingleFactory<T>) {
        return singletons[factory.runtimeType] = factory();
      }
    }

    throw Exception('No factory or finder for type $T');
  }
}
