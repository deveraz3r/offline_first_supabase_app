import 'package:offline_first_todo/home_screen.dart';
import 'package:offline_first_todo/utils/app_urls.dart';
import 'package:offline_first_todo/utils/routes/route_name.dart';

class Routes {
  //GetX routes
  static appRoutes() => [
    GetPage(name: RouteName.home, page: () => const MyApp()),
  ];
}
