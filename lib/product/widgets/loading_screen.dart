import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Widget child;
  const LoadingScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return widget.child;
            } else {
              return const Center(child: Text("Sayfa yüklenemedi"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
