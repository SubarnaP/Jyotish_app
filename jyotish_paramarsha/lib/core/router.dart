import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state_management/auth_provider.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/kundali/kundali_form.dart';
import '../presentation/screens/horoscope/horoscope_screen.dart';
import '../presentation/screens/chat/chat_screen.dart';
import '../presentation/screens/video_call/video_call_screen.dart';
import 'constants.dart';

class AppRoute {
  static GoRouter createRouter(AuthProvider authProvider) => GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final isLoggedIn = authProvider.isLoggedIn;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      
      if (!isLoggedIn && !isLoginRoute) {
        return AppRoutes.login;
      }
      if (isLoggedIn && isLoginRoute) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'kundali',
            name: 'kundali',
            builder: (context, state) {
              final params = state.extra as Map<String, dynamic>?;
              return KundaliFormScreen(
                initialName: params?['name'] as String?,
                initialDate: params?['date'] as DateTime?,
              );
            },
          ),
          GoRoute(
            path: 'horoscope',
            name: 'horoscope',
            builder: (context, state) => const HoroscopeScreen(),
          ),
          GoRoute(
            path: 'chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: 'video-call',
            name: 'videoCall',
            builder: (context, state) => const VideoCallScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}

// Custom page transitions
class CustomTransitionPage<T> extends Page<T> {
  final Widget child;
  final RouteTransitionsBuilder transitionsBuilder;
  final Duration transitionDuration;

  const CustomTransitionPage({
    required LocalKey key,
    required this.child,
    required this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder,
      transitionDuration: transitionDuration,
    );
  }
}

final appRouter = AppRoute.createRouter(AuthProvider());
