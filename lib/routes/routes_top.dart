import 'package:breach/routes/routes.dart';
import 'package:breach/routes/routes_branches.dart';
import 'package:breach/screens/login/ui/login_screen.dart';
import 'package:breach/screens/nav/nav_screen.dart';
import 'package:breach/screens/posts/ui/posts_screen.dart';
import 'package:breach/screens/register/ui/register_screen.dart';
import 'package:breach/screens/splash/splash_screen.dart';
import 'package:breach/screens/streams/ui/stream_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.splash,
  routes: topRoutes,
);

List<RouteBase> topRoutes = [
  GoRoute(
    path: Routes.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: Routes.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return NavScreen(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.posts,
            builder: (context, state) => const PostsScreen(),
            routes: postsRoutes,
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Routes.stream,
            builder: (context, state) => const StreamScreen(),
            routes: streamsRoutes,
          ),
        ],
      ),
    ],
  ),
];
