// import 'dart:isolate';
// import 'dart:math';
//
// void requestData(({int iteration, SendPort sendPort}) data) {
//   var total = 0.0;
//   int delta = Random().nextInt(200000000) - 100000000;
//
//   for (var i = 0; i < data.iteration + delta; i++) {
//     total += i;
//   }
//   data.sendPort.send(total);
// }
//
// class SomeDataRepo {
//   Future<void> getSomeData(ReceivePort receiverPort) async {
//     await Isolate.spawn(requestData, (iteration: 1000000000, sendPort:receiverPort.sendPort));
//   }
// }