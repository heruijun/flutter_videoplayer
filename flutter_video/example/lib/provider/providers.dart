import 'package:flutter_video_example/provider/LockMode.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static List<SingleChildWidget> _independentServices = [];

  static List<SingleChildWidget> _dependentServices = [];

  static List<SingleChildWidget> _consumableServices = [
    ChangeNotifierProvider<LockMode>(create: (context) => LockMode()),
  ];
}
