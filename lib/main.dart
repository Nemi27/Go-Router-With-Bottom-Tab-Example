import 'package:flutter/material.dart';
import 'package:go_router_page_demo/routes/app_routes.dart';

void main() {
  AppRoutes.routesData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRoutes.router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = "Home Page"});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          spacing: 40,
          runSpacing: 40,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            OutlinedButton(
                child: Text("Go To Bottom Tab"),
                onPressed: () {
                  AppRoutes.router.pushNamed(AppRoutes.dashboard);
                }),
            OutlinedButton(
                onPressed: () {
                  AppRoutes.router.pushNamed(AppRoutes.developerInformation);
                },
                child: Text("Developer Information")),
          ],
        ),
      ),
    );
  }
}
