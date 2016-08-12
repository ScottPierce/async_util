# async_util
Utility classes and functions to make async operations with dart easier.

Pull requests are welcome!

## Limiter

A class for limiting the number of async tasks that are pending in the 
async queue at a given time.

```Dart
// Only allow a single task to be pending in the async queue.
final limiter = new Limiter(1);
// Task 1
limiter.execute(() async => await new Future(() => print('Guaranteed to run first')));
// Task 2
limiter.execute(() => print('Guaranteed to run second'));
```