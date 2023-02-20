import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class PreviewChartPage extends StatefulWidget {
  const PreviewChartPage({Key? key}) : super(key: key);

  @override
  State<PreviewChartPage> createState() => _PreviewChartPageState();
}

class _PreviewChartPageState extends State<PreviewChartPage> {
  @override
  void initState() {
    super.initState();
    // rootBundle.loadString('assets/data.json').then((json) {
    //   final items = jsonDecode(json) as List<dynamic>;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CustomScrollBehavior(),
      home: Scaffold(
        body: SafeArea(
          child: Column(children: const [
            SizedBox(
              height: 300,
              child: Text('tmp'),
            ),
          ]),
        ),
      ),
    );
  }
}
