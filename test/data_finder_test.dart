import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_finder/data_finder.dart';

void main() {
  const MethodChannel channel = MethodChannel('data_finder');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DataFinder.platformVersion, '42');
  });
}
