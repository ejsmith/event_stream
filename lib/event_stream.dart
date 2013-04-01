library event_stream;

import 'dart:async';

abstract class NotifyPropertyChanged {
  Stream<PropertyChangedEventArgs> get onPropertyChanged;
}

class EventStream<T> {
  StreamController<T> _controller = new StreamController<T>.broadcast();
  Stream<T> get stream => _controller.stream;
  
  signal([T value]) {
    _controller.add(?value ? value : EventArgs.empty);
  }
}

class EventArgs {
  static final EventArgs empty = new EventArgs();
  EventArgs();
}

class PropertyChangedEventArgs<T> extends EventArgs {
  PropertyChangedEventArgs(String this.propertyName, T this.value);
  String propertyName;
  T value;
}