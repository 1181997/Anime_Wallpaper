import 'package:flutter/material.dart';
import 'category/category_page.dart';
import 'favourite_page/favourite_page.dart';
import 'home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );


  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children:  const <Widget>[
          HomePage(),
          CategoryPage(),
          FavouritePage()
        ],
      ),

      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 12,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: ClipRRect(

          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.8),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            currentIndex: bottomSelectedIndex,
            onTap: (index) {
              bottomTapped(index);
            },
            items: const [
              BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Group 5.png")),label: ''),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Vector.png")),label: ''),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Group 6.png")),label: ''),

            ],
          ),
        ),
      ),
    );
  }
}
