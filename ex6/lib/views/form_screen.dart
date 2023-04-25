import 'dart:convert';

import 'package:ex6/view_model/photo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/photo.dart';
import '../view_model/photo_view_model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final titleController = TextEditingController();
  final thumbnailUrlController = TextEditingController();
  final urlController = TextEditingController();
  final albumIdController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    thumbnailUrlController.dispose();
    urlController.dispose();
    albumIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New photo"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Photo title"),
                validator: (value) => (value == null || value == "")
                    ? "Title can't be empty"
                    : null,
              ),
              TextFormField(
                controller: thumbnailUrlController,
                decoration: const InputDecoration(labelText: "Thumbnail url"),
                validator: (value) => (value == null || value == "")
                    ? "Thumbnail url can't be empty"
                    : null,
              ),
              TextFormField(
                controller: albumIdController,
                decoration: const InputDecoration(labelText: "Album id"),
                validator: (value) => null
              ),
              TextFormField(
                controller: urlController,
                decoration: const InputDecoration(labelText: "Url"),
                validator: (value) => null
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  child: const Text("Add photo"),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      Map<String, dynamic> payload = {
                        'title' : titleController.text,
                        'thumbnailUrl': thumbnailUrlController.text,
                        'albumId' : int.parse(albumIdController.text),
                        'url' : urlController.text
                      };
                      String jsonPayload = jsonEncode(payload);
                      const String apiUrl = 'https://unreal-api.azurewebsites.net/photos';
                      Map<String, String> headers = {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                      };
                      http.post(
                        Uri.parse(apiUrl),
                        headers: headers,
                        body: jsonPayload,
                      );


                      titleController.text = "";
                      thumbnailUrlController.text = "";
                      albumIdController.text = "";
                      urlController.text = "";

                      final viewModel = Provider.of<PhotoViewModel>(
                        context,
                        listen: false,
                      );
                      viewModel.signalerAjoutPhoto();
                      Navigator.pop(context);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
