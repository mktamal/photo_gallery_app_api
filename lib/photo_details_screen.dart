import 'package:flutter/material.dart';
import 'package:photo_gallery_app_api/image_model.dart';

class PhotoDetails extends StatelessWidget {
  final ImageModel? imageModel;

  const PhotoDetails({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    print(imageModel?.url);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imageModel?.url ?? '',
              width: 600,
              errorBuilder: (context, error, stackTrace){
                return const SizedBox(
                  width: 600,
                  child: Text('Image not available'),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${imageModel?.title ?? 'Not available'}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Text('ID: ${imageModel?.id ?? 'Not available'}',
              style: const TextStyle(
              fontSize: 18,
            ),),
          ],
        ),
      ),
    );
  }
}
