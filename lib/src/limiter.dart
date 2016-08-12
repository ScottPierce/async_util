part of async_util;

/// A class for limiting the number of async tasks that are pending in the async
/// queue at a given time.
///
///     final limiter = new Limiter(1);
///     limiter.execute(() async => await new Future(() => print('Guaranteed to run first')));
///     limiter.execute(() => print('Guaranteed to run second'));
class Limiter {
  final int numParallelTasks;
  final Queue<_ExecutorItem> _queue = new Queue();

  int _tasksExecuting = 0;

  Limiter(this.numParallelTasks);

  Future<dynamic> execute(LimiterTask task) {
    if (_tasksExecuting < numParallelTasks) {
      return _executeTask(task);
    } else {
      Completer<dynamic> completer = new Completer();
      _queue.add(new _ExecutorItem(task, completer));
      return completer.future;
    }
  }

  Future<dynamic> _executeTask(LimiterTask task) {
    _tasksExecuting++;
    return task().then((result) {
      _tasksExecuting--;

      if (_queue.isNotEmpty) {
        final item = _queue.removeFirst();
        _executeTask(item.task).then((r) => item.completer.complete(r));
      }

      return result;
    });
  }
}

typedef Future<dynamic> LimiterTask();

class _ExecutorItem {
  final LimiterTask task;
  final Completer<dynamic> completer;

  _ExecutorItem(this.task, this.completer);
}