import 'package:flutter/material.dart';
import 'package:medico_app/models/modelResources.dart';
import 'package:medico_app/utils/card/card_landscape.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/views/resources/detail.dart';

class ListResources extends StatefulWidget {
  final String type;
  const ListResources({Key? key, required this.type}) : super(key: key);

  @override
  State<ListResources> createState() => _ListResourcesState();
}

class _ListResourcesState extends State<ListResources> {
  final ModelResources1 modelResources1 = ModelResources1(
      title: 'title',
      content: 'content',
      excerpt: 'excerpt',
      publishDate: '',
      author: 'author',
      slug: 'slug',
      imageLink: 'imageLink');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mPrimary,
        title: Text('Daftar ' + widget.type),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailResource(dataDetails: modelResources1))),
                  child: CardLandscape(
                    modelResources1: modelResources1,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
