# example
Here's a simple application that demonstrates how ArcAnimator works.

## Getting Started

```dart

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
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
            begin: Offset(60, 60), // your initial widget location
            end: Offset(size.width - 60, size.height - 60), // the desired end location
            controller: controller, // animation controller
            statusListener: (status) => print(status),
            offsetChanging: (offset) => print(offset),
            child: FloatingActionButton(
              onPressed: () => controller.forward(),
            ),
          )
        ],
      ),
    );
  }
}

```

