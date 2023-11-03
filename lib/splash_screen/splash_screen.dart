import 'package:flutter/material.dart';
import 'package:wallpaper_app/landing_page/landing_page_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changescreen(){
    Future.delayed(const Duration(milliseconds: 4000),
            (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LandingPage1()));

        }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    changescreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/gif/splash.gif",fit: BoxFit.fill,)
      ),
    );
  }
}
