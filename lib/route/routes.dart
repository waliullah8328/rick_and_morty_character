import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_character/feature/home_nav_bar/view/home_nav_bar_view.dart';
import 'package:rick_and_morty_character/route/routes_name.dart';



class Routes {
  static final GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteNames.homeNavBar,
    routes: [
      GoRoute(
        path: RouteNames.homeNavBar,
        builder: (context, state) => HomeNavBar(),
      ),
      // GoRoute(
      //   path: RouteNames.loginScreen,
      //   builder: (context, state) => LoginScreen(),
      // ),
      //

    ],
  );
}
