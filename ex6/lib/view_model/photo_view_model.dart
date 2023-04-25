import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class PhotoViewModel extends ChangeNotifier {
  Future<List<Photo>> _fetchPhotos() async {
    final response = await http.get(Uri.parse('https://unreal-api.azurewebsites.net/photos'));

    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode} fetching photos");
    }

    return compute((input) {
      final jsonList = jsonDecode(input);
      return jsonList.map<Photo>((jsonObj) => Photo.fromJson(jsonObj)).toList();
    }, response.body);
  }

  Future<List<Photo>> get futureListePhotos => _fetchPhotos();

  void signalerAjoutPhoto(){
    notifyListeners();
    }
}
