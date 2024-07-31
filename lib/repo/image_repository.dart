import 'package:helloworld/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageRepository {
  Future<List<ImageModel>> getNetworkImages() async {
    var endpointUrl = Uri.parse('https://www.colourlovers.com/api/colors/new?format=json');
    final response = await http.get(endpointUrl);
    if (response.statusCode == 200) {
      final List<dynamic> decodeList = jsonDecode(response.body) as List;

      final List<ImageModel> imageList = decodeList.map((listItem) {
        return ImageModel.fromJson(listItem);
      }).toList();
      print(imageList[0].imageUrl);
      return imageList;
    } else {
      throw Exception('API not successful!');
    }
  }
}
