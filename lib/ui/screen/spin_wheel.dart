import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokemon_app/ui/screen/roulette_paint.dart';

class SpinWheel extends StatefulWidget {
  final int resultNumber;
  final bool isRollToResult;
  const SpinWheel({
    Key? key,
    required this.resultNumber,
    required this.isRollToResult,
  }) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> with TickerProviderStateMixin {
  late AnimationController shakeController;
  var duration = const Duration(milliseconds: 500);
  var curve = Curves.bounceOut;
  late int indexOfResultNumber;
  var deltaX = 10;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _handleAnimation();
    return Scaffold(
      // body: Container(),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/pie_chart.png",
              height: 400,
              width: 400,
            ),
            const SizedBox(
              height: 204,
              width: 204,
              child: RoulettePaint(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }
}
