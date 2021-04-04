import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<int> unsortedList = [1, 2, 4, 3, 5, 7, 4, 6, 12, 13];
  bool isSorting = false;
  int counter = 0;
  List<int> sortedList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              Text('$unsortedList'),
              SizedBox(height: 24),
              if (isSorting)
                Text('Sorting ...')
              else
                Text('Sorted: $sortedList'),
              SizedBox(height: 24),
              RaisedButton(
                onPressed: () => sortList(),
                child: Text('Sort'),
              ),
              RaisedButton(
                onPressed: () => increaseCounter(),
                child: Text('Counter: $counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  Future<void> sortList() async {
    // Update UI to reflect the sort has started
    setState(() {
      isSorting = true;
    });

    final sorted = await compute(sortNumbers, unsortedList);
    setState(() {
      sortedList = sorted;
    });

    // Update UI to reflect the sort has finished
    setState(() {
      isSorting = false;
    });
  }
}

List<int> sortNumbers(List<int> numbers) {
  final List<int> easy = [...numbers]..sort();
  final List<int> sorted = [...numbers]..shuffle();

  while (!listEquals(easy, sorted)) {
    sorted.shuffle();
  }
  return sorted;
}
