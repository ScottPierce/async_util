import "package:test/test.dart";
import "package:async_util/async_util.dart";
import 'dart:async';

void main() {
  test('Limiter limits the number of async tasks that can run at a time', () async {
    final limiter = new Limiter(1);

    var value = 0;
    limiter.execute(() async => await new Future(() => expect(++value, equals(1))));
    final processedValue = await limiter.execute(() async {
      expect(++value, equals(2));
      return value;
    });

    expect(processedValue, equals(2));
  });
}