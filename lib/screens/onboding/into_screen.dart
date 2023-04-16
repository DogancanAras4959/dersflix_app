import 'package:dersflix_app/screens/onboding/login_page.dart';
import 'package:dersflix_app/screens/onboding/register_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageDecoration getPageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      boxDecoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.9
              ],
              colors: [
                Color(0xFFFF5530),
                Color(0xFFD53C1A),
              ]),
          borderRadius: BorderRadius.circular(10)),
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      bodyTextStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
      imagePadding: const EdgeInsets.all(0),
    );

    List<PageViewModel> pages = [
      PageViewModel(
        title: 'Randevunu Al',
        body: 'The man who neer reads lives only one',
        image: introImage("assets/Backgrounds/event_reg.png"),
        decoration: getPageDecoration,
      ),
      PageViewModel(
        title: 'Konularını Tamamla',
        body: 'The man who neer reads lives only one',
        image: introImage("assets/Backgrounds/event_reg.png"),
        decoration: getPageDecoration,
      ),
      PageViewModel(
        title: 'Dersflixle Hazır Ol',
        body: 'The man who neer reads lives only one',
        image: introImage("assets/Backgrounds/event_reg.png"),
        decoration: getPageDecoration,
      ),
    ];

    DotsDecorator getDotDecoration = DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Colors.white60,
        activeSize: const Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        activeColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ));

    return SafeArea(
      child: IntroductionScreen(
        globalFooter: Container(
          margin:
              const EdgeInsets.only(left: 30, right: 30, bottom: 25, top: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                primary: Colors.deepOrange,
                onPrimary: Colors.white),
            child: const Text(
              "Geri Dön",
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ),
        pages: pages,
        done: const Text(
          'Kayıt Ol',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        showSkipButton: true,
        skip: const Text('Atla',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        onSkip: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        showNextButton: true,
        next: const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
        ),
        dotsDecorator: getDotDecoration,
        bodyPadding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        globalBackgroundColor: Colors.white,
      ),
    );
  }

  Widget introImage(String path) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(path, width: 250.0),
    );
  }
}
