event_stream
============

[![](https://drone.io/github.com/ejsmith/event_stream/status.png)](https://drone.io/github.com/ejsmith/event_stream/latest)

## Introduction ##

event_stream makes it easier to expose custom events in Dart using the Stream API.

## Getting Started ##

1\. Add the following to your project's **pubspec.yaml** and run
```pub install```.

```yaml
dependencies:
  event_stream: any
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
  
  final EventStream<PropertyChangedEventArgs> _onPropertyChangedEvent = new EventStream<PropertyChangedEventArgs>();
  Stream<PropertyChangedEventArgs> get onPropertyChanged => _onPropertyChangedEvent.stream;
  
  final EventStream _onClosedEvent = new EventStream();
  Stream get onClosed => _onClosedEvent.stream;
  
  String get someProperty => _someProperty;
  set someProperty(String value) {
    _onPropertyChangedEvent.signal(new PropertyChangedEventArgs('someProperty', value));
    _someProperty = value;
  }
  
  close() {
    _onClosedEvent.signal();
  }
}

main() {
  var c = new ClassWithEvents();
  c.onPropertyChanged.listen((PropertyChangedEventArgs<String> args) => print('changed: name=${args.propertyName} value=${args.value}'));
  c.onClosed.listen((_) => print('closed'));
  c.someProperty = "test";
  c.close();
}
```
