import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_page_demo/main.dart';
import 'package:go_router_page_demo/routes/custom_page_builder.dart';
import 'package:go_router_page_demo/screens/dashboard_screen.dart';
import 'package:go_router_page_demo/screens/dev_information_screen.dart';

class AppRoutes {
  static const String homeScreen = '/homeScreen';
  static const String dashboard = '/dashboard';

  ////////////// BOTTOM TAB SCREEN NAME ////////////////
  static const String home = 'home';
  static const String settings = 'settings';
  static const String profile = 'profile';

  ///////////// WITHOUT BOTTOM TAB SCREEN ////////////////
  static const String developerInformation = '/developerInformation';

  static late final GoRouter router;

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState>? authNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState>? dashboardNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState>? shellNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRoutes.routesData() {
    final List<RouteBase> routes = <RouteBase>[
      StatefulShellRoute.indexedStack(
          parentNavigatorKey: shellNavigatorKey,
          pageBuilder: (context, state, navigationShell) {
            return CustomPageBuilder.getTransitionPage(
              context: context,
              state: state,
              transitionType: TransitionType.rightToLeft,
              child: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(navigatorKey: authNavigatorKey, routes: [
              GoRoute(
                path: homeScreen,
                name: homeScreen.replaceAll("/", ""),
                pageBuilder: (context, state) =>
                    CustomPageBuilder.getTransitionPage(
                        context: context,
                        state: state,
                        transitionType: TransitionType.scale,
                        child: const MyHomePage()),
                builder: (context, state) => const MyHomePage(),
              ),
              ////////////// Add Additional routes here ////////
            ])
          ]),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, navigationShell) {
          return CustomPageBuilder.getTransitionPage(
            context: context,
            state: state,
            transitionType: TransitionType.scale,
            child: DashboardScreen(
              title: (state.name ?? "").replaceAll("/", ""),
              child: navigationShell,
            ),
          );
        },
        branches: [
          StatefulShellBranch(navigatorKey: dashboardNavigatorKey, routes: [
            GoRoute(
              path: dashboard,
              name: dashboard,
              routes: [
                GoRoute(
                    path: home,
                    name: home,

                    ///// Todo: USE FOR REDIRECTION Handling ////
                    // redirect: (context, state) {
                    //   if (SessionHelper.instance.loginResponse?.token != null) {
                    //     return state.name;
                    //   } else {
                    //     return login;
                    //   }
                    // },
                    pageBuilder: (context, state) {
                      return CustomPageBuilder.getTransitionPage(
                          context: context,
                          state: state,
                          child: const Center(
                            child: Text("Home"),
                          ));
                    }),
                GoRoute(
                  path: settings,
                  name: settings,
                  pageBuilder: (context, state) {
                    return CustomPageBuilder.getTransitionPage(
                        context: context,
                        state: state,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    AppRoutes.router.pushNamed(
                                        AppRoutes.developerInformation);
                                  },
                                  child: const Text("Developer Information")),
                            ],
                          ),
                        ));
                  },
                ),
                GoRoute(
                    path: profile,
                    name: profile,
                    pageBuilder: (context, state) {
                      return CustomPageBuilder.getTransitionPage(
                          context: context,
                          state: state,
                          child: const Center(
                            child: Text("Profile"),
                          ));
                    }),
              ],
              pageBuilder: (context, state) =>
                  CustomPageBuilder.getTransitionPage(
                      context: context, state: state, child: Container()),
              parentNavigatorKey: dashboardNavigatorKey,
            ),
          ])
        ],
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: shellNavigatorKey,
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: developerInformation,
              name: developerInformation,
              pageBuilder: (context, state) =>
                  CustomPageBuilder.getTransitionPage(
                      context: context,
                      state: state,
                      transitionType: TransitionType.scale,
                      child: DevInfoScreen(
                          title: (state.name ?? "").replaceAll("/", ""))),
            ),
          ])
        ],
        builder: (context, state, child) => child,
      )
    ];
    router = GoRouter(
      routes: routes,
      navigatorKey: shellNavigatorKey,
      initialLocation: homeScreen,
    );
  }

  // GoRouter router = GoRouter(
  //     errorBuilder: (context, state) {
  //       return const Material(
  //         child: MyNetworkImage(
  //             imageUrl:
  //                 "https://cdn.dribbble.com/users/1190086/screenshots/7780963/media/02564c983af71888c5ba1091cb136101.gif"),
  //       );
  //     },
  //     navigatorKey: navigatorKey,
  //     routes: [
  //       GoRoute(
  //         path: splash,
  //         name: splash,
  //         pageBuilder: (context, state) => CustomPageBuilder.getTransitionPage(
  //             context: context,
  //             state: state,
  //             transitionType: TransitionType.scale,
  //             child: const SplashScreen()),
  //         builder: (context, state) => const SplashScreen(),
  //       ),
  //       GoRoute(
  //         path: login,
  //         name: login,
  //         pageBuilder: (context, state) => CustomPageBuilder.getTransitionPage(
  //             context: context,
  //             state: state,
  //             transitionType: TransitionType.size,
  //             child: const LoginScreen()),
  //         builder: (context, state) => const LoginScreen(),
  //       ),
  //
  //       /// DASHBOARD
  //       GoRoute(
  //         path: dashboard,
  //         name: dashboard,
  //         routes: [
  //           GoRoute(
  //             path: homeScreen,
  //             name: homeScreen,
  //             pageBuilder: (context, state) =>
  //                 CustomPageBuilder.getTransitionPage(
  //                     context: context,
  //                     state: state,
  //                     transitionType: TransitionType.leftToRight,
  //                     child: const HomeScreen()),
  //           )
  //         ],
  //         pageBuilder: (context, state) => CustomPageBuilder.getTransitionPage(
  //             context: context,
  //             state: state,
  //             transitionType: TransitionType.leftToRight,
  //             child: const DashBoardScreen()),
  //         redirect: (context, state) {
  //           return dashboard;
  //         },
  //         parentNavigatorKey: navigatorKey,
  //         builder: (context, state) => const DashBoardScreen(),
  //       ),
  //     ]);
}
