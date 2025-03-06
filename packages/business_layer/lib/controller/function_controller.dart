// Import Layers
//import 'package:business_layer/business_layer.dart';
import 'package:business_layer/business_layer.dart';
import 'package:data_layer/data_layer.dart';



class FunctionController {
  static Function hFunc1 = heavyFunction1;
  //() => heavyFunction1;
  //void hFunc1() => locator.get()();
  //void hFunc1() => heavyFunction1;
  void hFunc2() => heavyFunction2;
  void hFunc3() => heavyFunction3;
}