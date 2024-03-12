import 'package:flutter/material.dart';

class DevInfoScreen extends StatelessWidget {
  final String title;
  const DevInfoScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    const objSpace = SizedBox.square(
      dimension: 16,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: const SafeArea(
          minimum: EdgeInsets.all(16),
          child: Center(
            child: SelectionArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Developed By: Nemi Kardani"),
                  objSpace,
                  Text("Email: nemikardani6867.com"),
                  objSpace,
                  Text("Version: 0.0.1"),
                ],
              ),
            ),
          )),
    );
  }
}
