import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper_app/bottom.dart';
import 'package:wallpaper_app/favourite_page/favourite_page.dart';


class FavouriteFullViewPage extends StatefulWidget {
  final String imageUrl;

  const FavouriteFullViewPage({super.key, required this.imageUrl});


  @override
  State<FavouriteFullViewPage> createState() => _FavouriteFullViewPageState();
}

class _FavouriteFullViewPageState extends State<FavouriteFullViewPage> {
  bool isFavorite = true;
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        globalFavorites.add(widget.imageUrl);
      } else {
        globalFavorites.remove(widget.imageUrl);
      }
    });
  }

  void downloadImage(String imageUrl) async {
    try {
      final isSuccess = await GallerySaver.saveImage(imageUrl);
      if (isSuccess!) {
        // Image saved successfully
        print('Image saved to gallery');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,

            margin: EdgeInsets.symmetric(horizontal: 20),
            content: SizedBox(
                width: 150,
                height: 20,
                child: Text('Image Saved Successfully!.....')),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
      } else {
        // Failed to save the image
        print('Failed to save the image to gallery');
      }
    } catch (e) {
      print('Error while saving image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 40,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Spacer(),
                      Container(
                        width: 66,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                            onPressed:toggleFavorite

                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 66,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_downward_outlined,color: Colors.white,),
                          onPressed: () {
                            downloadImage(widget.imageUrl);
                          },
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 66,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          icon: const ImageIcon(AssetImage("assets/images/Group 5.png"),color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
                          },
                        ),
                      ),
                      const Spacer(
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
