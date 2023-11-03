import 'package:flutter/material.dart';

import 'category_detail_page.dart';

class Category {
  final String name;
  final String image;

  Category(this.name, this.image);
}


class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Category> categories = [
    Category("Action", "assets/images/category/1action.png"),
    Category("Mystery", "assets/images/category/2mystery.png"),
    Category("Drama", "assets/images/category/3drama.png"),
    Category("Romance", "assets/images/category/4romance.png"),
    Category("Adventure", "assets/images/category/5adventure.png"),
    Category("Horror", "assets/images/category/6horror.png"),
    Category("Comedy", "assets/images/category/7comedy.png"),
    Category("Pshycological", "assets/images/category/8pshycological.png"),
    Category("Fantacy", "assets/images/category/9fantacy.png"),
    Category("Mecha", "assets/images/category/10mecha.png"),
    Category("Supernatural", "assets/images/category/11supernatural.png"),
    Category("Seinen", "assets/images/category/12seinen.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const Text(
              'Browse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),

            const SizedBox(height: 5,),
            const Text(
              'Category you like',
              style: TextStyle(
                color: Color(0xFFB3B3B3),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            Expanded(
              child: GridView.builder(itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (context,index){
                    final category = categories[index];
                    return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>CategoryDetailPage(category: category,)));
                        },
                        child: Container(
                            color: Colors.black,
                            height: 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                      category.image,fit: BoxFit.fill,),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(category.name,style: const TextStyle(color: Colors.white),)
                                ])));
                  }
              ),
            )
          ],
        ),
      ),

    );
  }
}




