import 'package:flutter/material.dart';
import 'package:wallpaper_app/bottom.dart';
import 'package:wallpaper_app/landing_page/landing_page_3.dart';


class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              // User swiped to the right
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LandingPage3(), // Replace 'SecondPage' with the actual second page.
                ),
              );
            }
          },
          child: Container(
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                const Text(
                  'Epic Anime \n Wallpapers Await!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 350,
                  margin: const EdgeInsets.symmetric(horizontal: 51),
                  child: Image.asset("assets/images/landing2.png",),
                ),
                const Text(
                  'Immerse Yourself in the Largest\n Anime Wallpaper Collection on Our App ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
                      },
                          child: const Text("SKIP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                            ),)
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LandingPage3(),
                              ));
                        },
                        child: Container(
                            width: 50,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x26252C61),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0x338890C2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],

                            ),
                            child: const Text(">",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
