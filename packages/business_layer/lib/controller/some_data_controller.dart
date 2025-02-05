// Import Flutter
import 'dart:isolate';

// Import Layers
import 'package:business_layer/business_layer.dart';
import 'package:data_layer/data_layer.dart';

class SomeDataController {
  Future<void> getData(ReceivePort port) async => await locator.get<SomeDataRepo>().getSomeData(port);
}