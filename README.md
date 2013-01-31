event_stream
============

[![](https://drone.io/ejsmith/event_stream/status.png)](https://drone.io/ejsmith/event_stream/latest)

## Introduction ##

EventStream makes it easier to expose custom events in Dart.

## Getting Started ##

1\. Add the following to your project's **pubspec.yaml** and run
```pub install```.

```yaml
dependencies:
  event_stream:
    git: https://github.com/ejsmith/event_stream.git
```

2\. Add the correct import for your project.

```dart
import 'package:event_stream/event_stream.dart';
```

## Example ##

```dart
import 'package:event_stream/event_stream.dart';

import 'dart:async';

class ClassWithEvents implements NotifyPropertyChanged {
  String _someProperty;
  String _someOtherProperty;
  int _someIntProperty;
  
  final EventStream<PropertyChangedEventArgs> _onPropertyChangedEvent = new EventStream<PropertyChangedEventArgs>();
  Stream<PropertyChangedEventArgs> get onPropertyChanged => _onPropertyChangedEvent.stream;
  
  final EventStream _onClosedEvent = new EventStream();
  Stream get onClosed => _onClosedEvent.stream;
  
  String get someProperty => _someProperty;
  set someProperty(String value) {
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someProperty', value));
    _someProperty = value;
  }
  
  String get someOtherProperty => _someOtherProperty;
  set someOtherProperty(String value) {
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someOtherProperty', value));
    _someOtherProperty = value;
  }
  
  int get someIntProperty => _someIntProperty;
  set someIntProperty(int value) {
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someIntProperty', value));
    _someIntProperty = value;
  }
  
  close() {
    _onClosedEvent.signal();
  }
}

main() {
  var c = new ClassWithEvents();
  c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => print('listen1: name=${args.propertyName} value=${args.value} type=${args.value.runtimeType}'));
  c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => print('listen2: name=${args.propertyName} value=${args.value} type=${args.value.runtimeType}'));
  c.onClosed.listen((_) => print('closed1'));
  c.onClosed.first.whenComplete(() => print('first closed'));
  c.someProperty = "test1";
  c.someOtherProperty = "test1";
  c.someProperty = "test2";
  c.someOtherProperty = "test2";
  c.someIntProperty = 1;
  c.close();
  c.close();
}
```
