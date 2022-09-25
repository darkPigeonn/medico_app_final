import 'package:flutter/material.dart';
import 'package:medico_app/models/modelResources.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/text_style.dart';

class CardLandscape extends StatelessWidget {
  final ModelResources1 modelResources1;
  const CardLandscape({Key? key, required this.modelResources1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mWhite,
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue.shade50,
              child: SizedBox(
                height: 70,
                width: 70,
                child: Center(
                  child: Text('PNG'),
                ),
              ),
            ),
            Container(
                width: size.width * 0.6,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Judul',
                      style: titleCard,
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: excerptCard,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
