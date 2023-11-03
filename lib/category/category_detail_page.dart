import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'Full_view_page.dart';
import 'category_page.dart';

class CategoryDetailPage extends StatefulWidget {
  final Category category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  void getFiles() async {
    print('getFiles called');
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('images/${widget.category.name}');

    try {
      ListResult result = await ref.listAll();
      print('ListResult: $result');
      for (var item in result.items) {
        String url = await item.getDownloadURL();
        print('URL: $url');
        setState(() {
          imageUrls.add(url);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.category.name),
      ),
      body: Container(
        color: Colors.black,
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullViewPage(imageUrl: imageUrls[index]),
                  ),
                );
              },
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(5),

                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
            ));
          },
        ),
      ),
    );
  }
}