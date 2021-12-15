// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of 'single.dart';

class _SingleImpl implements Single {
  _SingleImpl() {
    _register<Single>(() => this);
  }

  @override
  void operator +(SingleFactory factory) => _register(factory);

  @override
  T call<T extends Object>() => _find<T>();

  @override
  List<SingleFactory<Object>> get factories => _factories;

  final Map<Type, Object> _singletons = {};
  final List<SingleFactory<Object>> _factories = [];

  void _register<T extends Object>(SingleFactory<T> factory) {
    if (_factories
        .any((element) => element.runtimeType == factory.runtimeType)) {
      throw Exception('Factory of type $T has been registered');
    }

    _factories.add(factory);
  }

  T _find<T extends Object>() {
    if (_singletons.containsKey(T)) {
      return _singletons[T] as T;
    }

    if (!factories.any((element) => element.runtimeType == SingleFactory<T>)) {
      throw Exception('Factory of type $T has not been registered');
    }

    final SingleFactory<T> factory =
        factories.whereType<SingleFactory<T>>().single;

    return _singletons[factory.runtimeType] = factory.call();
  }
}
