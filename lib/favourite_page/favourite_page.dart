import 'package:flutter/material.dart';
import 'favourite_full_view.dart';

List<String> globalFavorites = [];
class Favourite {
  final String image;

  Favourite( this.image);
}

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {



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
              'Favourites',
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
              'Your collection',
              style: TextStyle(
                color: Color(0xFFB3B3B3),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            Expanded(
              child: GridView.builder(itemCount: globalFavorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                      childAspectRatio:0.6 ),

                  itemBuilder: (context,index){
                    final imageUrl = globalFavorites[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FavouriteFullViewPage(imageUrl: imageUrl,)));
                      },
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.all(5),
                          child: Image.network(imageUrl, fit: BoxFit.fill),
                        ));
                  }
              ),
            )
          ],
        ),
      ),

    );
  }
}
