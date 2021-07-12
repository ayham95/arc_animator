import 'package:arc_animator/arc_animator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ArcAnimator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter ArcAnimator Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          ArcAnimator(
            curve: Curves.easeInOutSine,
            begin: Offset(60, 60),
            end: Offset(size.width - 60, size.height - 60),
            controller: controller!,
            statusListener: (status) => print(status),
            offsetChanging: (offset) => print(offset),
            child: FloatingActionButton(
              onPressed: () => controller!.forward(),
            ),
          )
        ],
      ),
    );
  }
}
