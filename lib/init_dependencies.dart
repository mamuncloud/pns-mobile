import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Add dependencies here
  _initCounter();
}

void _initCounter() {
  // Counter dependencies
}
