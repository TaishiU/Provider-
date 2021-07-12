import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final countStateProvider = StateProvider((ref) => 0);
//
// final count10Provider = Provider((ref) {
//   final count = ref.watch(countStateProvider).state;
//   return count * 10;
// });

final countStateProvider =
    StateNotifierProvider<CountState, int>((ref) => CountState(0));

class CountState extends StateNotifier<int> {
  CountState(int count) : super(count);

  void increment() => state = state + 1;
  void decrement() => state = state - 1;
}

final count10Provider = Provider((ref) {
  final count = ref.watch(countStateProvider);
  return count * 10;
});

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useProvider(countStateProvider);
    final count10 = useProvider(count10Provider);

    return Scaffold(
      appBar: AppBar(
        title: Text('ref test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${count10}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.exposure_minus_1),
                    onPressed: () =>
                        context.read(countStateProvider.notifier).decrement(),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () =>
                        context.read(countStateProvider.notifier).increment(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
