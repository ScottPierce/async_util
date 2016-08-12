# Limiter

A class for limiting the number of async tasks that are pending at a given
time.

## Usage
```Dart
final limiter = new Limiter(1); // Creates a
limiter.execute(() async => await new Future(() => print('Guaranteed to run first')));
limiter.execute(() => print('Guaranteed to run second'));
```