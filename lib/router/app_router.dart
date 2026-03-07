import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/breakpoints.dart';
import 'package:my_portfolio/constants/projects_model_info.dart';
import 'package:my_portfolio/models/projects_info.dart';
import 'package:my_portfolio/pages/desktop/desktop_home_page.dart';
import 'package:my_portfolio/pages/desktop/project_detail_page_desktop.dart';
import 'package:my_portfolio/pages/mobile/mobile_home_page.dart';
import 'package:my_portfolio/pages/mobile/project_detail_page_mobile.dart';
import 'package:my_portfolio/pages/splash_page.dart';

/// Named route constants to avoid hardcoded strings.
class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String projectDetail = '/projects/:slug';

  /// Helper to build a project detail path from a project slug.
  static String projectDetailPath(String slug) => '/projects/$slug';
}

/// The application's route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= Breakpoints.desktop) {
              return const ComputerHomePage();
            } else if (constraints.maxWidth >= Breakpoints.mobile) {
              return const ComputerHomePage(isTablet: true);
            } else {
              return const MobileHomePage();
            }
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ),
    GoRoute(
      path: AppRoutes.projectDetail,
      builder: (context, state) {
        final slug = state.pathParameters['slug'] ?? '';
        final project = Project.findBySlug(myProjects, slug);

        if (project == null) {
          // If no project matches the slug, redirect to home.
          return const _NotFoundPage();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= Breakpoints.desktop) {
              return ProjectDetailPageDesktop(project: project);
            } else if (constraints.maxWidth >= Breakpoints.mobile) {
              return ProjectDetailPageDesktop(project: project, isTablet: true);
            } else {
              return ProjectDetailPageMobile(project: project);
            }
          },
        );
      },
    ),
  ],

  // Redirect unknown routes to home.
  errorBuilder: (context, state) => const _NotFoundPage(),
);

/// A simple 404 page that redirects back to /home after a short delay.
class _NotFoundPage extends StatefulWidget {
  const _NotFoundPage();

  @override
  State<_NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<_NotFoundPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Page not found. Redirecting to home...'),
          ],
        ),
      ),
    );
  }
}
