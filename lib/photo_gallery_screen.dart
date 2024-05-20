import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_gallery_app_api/image_model.dart';
import 'package:photo_gallery_app_api/photo_details_screen.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  bool _getPhotoGalleryListInProgress = false;
  List<ImageModel> imageList = [];

  @override
  void initState() {
    super.initState();
    _getPhotoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: Visibility(
        visible: _getPhotoGalleryListInProgress == false,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return _buildSingleListItem(imageList[index]);
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: imageList.length,
        ),
      ),
    );
  }

  Widget _buildSingleListItem(ImageModel imageModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PhotoDetails(imageModel: imageModel)));
      },
      child: ListTile(
        leading: Image.network(
          imageModel.thumbnailUrl ?? '',
          height: 60,
          width: 60,
        ),
        title: Text(imageModel.title ?? ''),
      ),
    );
  }

  Future<void> _getPhotoList() async {
    _getPhotoGalleryListInProgress == true;
    setState(() {});
    imageList.clear();

    const String imageListUrl = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(imageListUrl);
    Response response = await get(uri);

    /*print(response.statusCode);
    print(response.body);*/

    if (response.statusCode == 200) {
      //decode
      final decodedData = jsonDecode(response.body);

      // get the list
      //final iamgeList = decodedData['data'];

      // loop over the list
      for (Map<String, dynamic> json in decodedData) {
        ImageModel imageModel = ImageModel.fromJson(json);
        imageList.add(imageModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load images'),
        ),
      );
    }

    _getPhotoGalleryListInProgress = false;
    setState(() {});
  }
}
