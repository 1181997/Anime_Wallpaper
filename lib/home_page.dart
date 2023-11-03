import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/category/Full_view_page.dart';
import 'package:wallpaper_app/category/category_detail_page.dart';

import 'category/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentPageIndex = 0;


  List<String> categories = ["Comedy", "Action", "Romance", "Adventure", "Mystery", "Horror"];

  List<List<String>> categoryImages = [
    ["assets/images/comedy.png"],
    ["assets/images/action.png"],
    ["assets/images/romance.png"],
    ["assets/images/adventure.png"],
    ["assets/images/mystery.png"],
    ["assets/images/horror.png"],
  ];

  List<String> Adventure = [];
  List<String> action = [];
  List<String> Romance = [];

  @override
  void initState() {
    super.initState();
    fetchImages('Adventure').then((images) {
      setState(() {
        Adventure = images;
      });
    });
    fetchImages('Action').then((images) {
      setState(() {
        action = images;
      });
    });
    fetchImages('Romance').then((images) {
      setState(() {
        Romance = images;
      });
    });
  }


  Future<List<String>> fetchImages(String category) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference rootRef = storage.ref().child('images/$category');
    ListResult result = await rootRef.listAll();
    List<Reference> refs = result.items;

    // Shuffle the list of references
    var random = Random();
    print(random);


    int count = min(3, refs.length); // Limit to 3 or the number of available images
    List<String> urls = [];

    for (var i = 0; i < count; i++) {
      String url = await refs[i].getDownloadURL();
      urls.add(url);
    }

    return urls;
  }

  //
  // Future<List<String>> fetchImages(String category) async {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference rootRef = storage.ref().child('images/$category');
  //   ListResult result = await rootRef.listAll();
  //   List<Reference> refs = result.items;
  //   var random = Random();
  //   List<String> urls = [];
  //   for (var i = 0; i < min(3, refs.length); i++) {
  //     int randomIndex = random.nextInt(refs.length);
  //     String url = await refs[randomIndex].getDownloadURL();
  //     urls.add(url);
  //   }
  //   return urls;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 31,),
              Row(
                children: [

                  Container(
                    width: 28,
                    height: 32,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/home1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'Anime Verse',
                    style: TextStyle(
                      color: Color(0xFFFFF502),
                      fontSize: 24,
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20,bottom: 11),
                child: const Text(
                  'All Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),

              buildCategoryGrid(),

              const SizedBox(height: 10),
              buildCategoryList('Adventure', Adventure),
              const SizedBox(height: 10),
              buildCategoryList('Action', action),
              const SizedBox(height: 10),
              buildCategoryList('Romance', Romance),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildCategoryGrid() {
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: 150,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2.4
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return buildCategoryItem(categories[index], categoryImages[index][0]);
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem(String categoryName, String categoryImage) {
    return GestureDetector(
      onTap: () {
        Category category = Category(categoryName,categoryImage);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryDetailPage(category: category),
          ),
        );
      },
      child: Container(

        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1919),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              clipBehavior: Clip.antiAlias,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(categoryImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              height: 23,
              width: 58,
              child: Text(
                categoryName,
                style: const TextStyle(
                  color: Color(0xFFC2C2C2),
                  fontSize: 13.50,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildCategoryList(String title, List<String> images) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: ShapeDecoration(
        color: const Color(0xFF191818),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            child: Row(
              children: [
                for (String imageUrl in images)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullViewPage(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.275,
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image.network(
                        imageUrl, // Use Image.network to display images from URLs
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //
  // Widget buildCategoryList(String title, List<String> images) {
  //   return Container(
  //     height: 250,
  //     decoration: ShapeDecoration(
  //       color: const Color(0xFF191818),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  //           child: Row(
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 14,
  //                   fontFamily: 'Poppins',
  //                   fontWeight: FontWeight.w600,
  //                   height: 0,
  //                 ),
  //               ),
  //               const Spacer(),
  //
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 5,),
  //         GestureDetector(
  //           onTap: (){
  //             String imageurl = images.isNotEmpty ? images.first : "";
  //             Navigator.push((context), MaterialPageRoute(builder: (context)=>FullViewPage(imageUrl: imageurl)));
  //           },
  //             child: SizedBox(
  //             height: 200,
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               scrollDirection: Axis.horizontal,
  //               itemCount: images.length,
  //               itemBuilder: (context, index) {
  //                 try {
  //                   return Container(
  //                     width: 118,
  //                     height: 200,
  //                     margin: const EdgeInsets.only(right: 10),
  //                     child: Image.network(images[index], // Use Image.network to display images from URLs
  //                       fit: BoxFit.cover,
  //
  //                     ),
  //                   );
  //                 } catch (e) {
  //                   print('Error loading image: $e');
  //                   return Container();
  //                 }
  //               },
  //
  //             ),
  //
  //         ))
  //           ],
  //     ),
  //   );
  // }

}



