import 'package:flutter/material.dart';
import 'package:helloworld/models/image_model.dart';
import 'package:helloworld/repo/image_repository.dart';

class PickerBody extends StatelessWidget {
  final Function(String) onImageSelected;
  PickerBody({super.key, required this.onImageSelected});
  final ImageRepository _imageRepo = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: FutureBuilder<List<ImageModel>>(
          future: _imageRepo.getNetworkImages(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ImageModel>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          onImageSelected(snapshot.data![index].imageUrl);
                        },
                        child: Image.network(snapshot.data![index].imageUrl));
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 75,
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width / 3));
            }
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
