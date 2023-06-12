import 'package:anim/stars_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Size size;
  late double width;
  late double height;
  late double buttonWidth;
  late double buttonHeight;
  late double flowersWidth;
  late double flowersHeight;

  double dx = -1;
  bool shouldOn = true;
  Color buttonColor = Colors.blue.shade200;
  double turns = 0;
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  int starsColorOpacity = 0;

  late double starsWidth;
  late double starsHeight;

  var bgColor = Colors.blueGrey.shade200;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    buttonWidth = width * 0.25;
    buttonHeight = height * 0.05;
    flowersWidth = buttonWidth * 0.3;
    flowersHeight = buttonHeight * 0.6;
    starsWidth = buttonWidth * 0.3;
    starsHeight = buttonHeight * 0.8;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width * 0.25,
          height: height * 0.1,
          child: GestureDetector(
            onTap: buttonOnTap,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: buttonOnTap,
                  child: AnimatedContainer(
                    padding: EdgeInsets.only(
                        left: buttonWidth * 0.05, right: buttonWidth * 0.05),
                    alignment: Alignment.centerLeft,
                    duration: const Duration(milliseconds: 300),
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(360)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: starsWidth,
                          color: Colors.transparent,
                          height: starsHeight,
                          child: CustomPaint(
                            painter: StarsPainter(
                                starsColorOpacity: starsColorOpacity),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedAlign(
                    duration: const Duration(milliseconds: 400),
                    alignment: Alignment(dx, 0),
                    child: AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 400),
                      child: AnimatedCrossFade(
                          firstChild: SizedBox(
                            width: buttonWidth * 0.5,
                            height: buttonHeight * 1.6,
                            child: Image.asset('assets/images/sun.png'),
                          ),
                          secondChild: SizedBox(
                            width: buttonWidth * 0.5,
                            height: buttonHeight * 1,
                            child: Image.asset('assets/images/moon.png'),
                          ),
                          crossFadeState: crossFadeState,
                          duration: const Duration(milliseconds: 400)),
                    )),
                Align(
                  alignment: const Alignment(1, 0.25),
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 100),
                    width: flowersWidth,
                    height: flowersHeight,
                    curve: Curves.bounceInOut,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(15)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/flower.png'))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buttonOnTap() async {
    if (shouldOn) {
      setState(() {
        dx = 1.2;
        turns = 1;
        buttonColor = Colors.black87;
        starsColorOpacity = 255;
        starsWidth = buttonWidth * 0.6;
        starsHeight = buttonHeight * 0.6;
        crossFadeState = CrossFadeState.showSecond;
        flowersWidth = 0;
        flowersHeight = 0;
        bgColor = Colors.blueGrey;
        shouldOn = false;
      });
    } else {
      setState(() {
        dx = -1;
        turns = 0;
        buttonColor = Colors.blue.shade200;
        starsColorOpacity = 0;
        starsWidth = buttonWidth * 0.3;
        starsHeight = buttonHeight * 0.6;
        flowersWidth = buttonWidth * 0.3;
        flowersHeight = buttonHeight * 0.7;
        bgColor = Colors.blueGrey.shade100;

        crossFadeState = CrossFadeState.showFirst;
        shouldOn = true;
      });
    }
  }
}
