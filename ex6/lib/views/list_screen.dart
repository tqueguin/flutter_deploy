import 'package:ex6/view_model/photo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/photo.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Photos"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/addScreen");
              },
              child: const Icon(Icons.add),
            ),
            body: FutureBuilder<List<Photo>>(
              future: Future.delayed(const Duration(seconds: 4), () => viewModel.futureListePhotos),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      int itemCount = snapshot?.data?.length ?? 0;
                      itemCount - 1 - index;
                      final photo = snapshot.data?[itemCount - 1 - index];
                      return PhotoRow(photo: photo!);
                    }
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  return Scaffold(
                      body: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blueAccent,
                      size: 75,
                  ),
                ));
                }
              },
            ),
          );
        }
    );
  }
}



class PhotoRow extends StatelessWidget {
  final Photo photo;

  const PhotoRow({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(photo.thumbnailUrl?.isEmpty ?? true ? 'https://via.placeholder.com/150/b6a14f' : photo.thumbnailUrl!, height: 60),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                "${photo.id} ${photo.title}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

