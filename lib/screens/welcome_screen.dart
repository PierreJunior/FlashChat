import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //use Single because we only have one animation. Otherwise use TickerProvider
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation =
        ColorTween(begin: Colors.black, end: Colors.indigo).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 10,
                  key: const ValueKey(AnimatedTextKit),
                  animatedTexts: [
                    ColorizeAnimatedText('Flash Chat',
                        textStyle: kLoginTextStyle, colors: kloginColorize),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              pressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              colour: Colors.lightBlueAccent,
              title: 'Log In',
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              pressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
