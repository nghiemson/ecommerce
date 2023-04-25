import 'package:rxdart/rxdart.dart';

// An in-memory store backed by BehaviorSubject that can be used to store data for all fake repo
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  //The BehaviorSubject that holds the data
  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  void close() => _subject.close();

}