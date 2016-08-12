# async_util
Utility classes and functions to make async operations with dart easier.

Pull requests are welcome!

## Limiter

A class for limiting the number of async tasks that are pending at a given
time.

```Dart
final limiter = new Limiter(1); // Creates a
limiter.execute(() async => await new Future(() => print('Guaranteed to run first')));
limiter.execute(() => print('Guaranteed to run second'));
```