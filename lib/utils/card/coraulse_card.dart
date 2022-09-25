import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';

class CorauselCard extends StatefulWidget {
  // final List<ModelResources1> list;
  final String title;

  CorauselCard({
    Key? key,
    required this.title,
    //required this.list
  }) : super(key: key);

  @override
  State<CorauselCard> createState() => _CorauselCardState();
}

class _CorauselCardState extends State<CorauselCard> {
  final String urlImage =
      'https://static.imavi.org/komunio/archived/komunio_media/';
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 12),
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailResource(
                  //       dataDetails: widget.list[index],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                      // image:
                      // widget.list[index].imageLink != 'kosong' ?
                      // DecorationImage(
                      //     image:

                      //         NetworkImage(
                      //           widget.list[index].imageLink.contains('https') ?
                      //           widget.list[index].imageLink :
                      //           urlImage + widget.list[index].imageLink),
                      //     fit: BoxFit.cover)
                      // :
                      // DecorationImage(
                      //     image:
                      //         NetworkImage(
                      //           urlImage + 'images/LOGO_KEUSKUPAN.jpg'),
                      //     fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8),
                      color: mPrimary),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 300,
                      )
                      // Container(
                      //   width: 100,
                      //   padding: EdgeInsets.only(top: 10),
                      //   child: Image.network(
                      //     urlImage + widget.list[index].imageLink,
                      //     width: 200,
                      //     height: 100,
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Container(
                      //           padding:
                      //               EdgeInsets.only(top: 10, left: 10, right: 10),
                      //           width: 300,
                      //           decoration: BoxDecoration(
                      //             gradient: LinearGradient(
                      //               begin: Alignment.topCenter,
                      //               end: Alignment.bottomCenter,
                      //               colors: [
                      //                 Color.fromARGB(19, 255, 255, 255),
                      //                Color.fromARGB(126, 0, 0, 0),
                      //                Color.fromARGB(200, 0, 0, 0),
                      //                Color.fromARGB(210, 0, 0, 0),
                      //               ]
                      //             ),
                      //             borderRadius: BorderRadius.only(
                      //               bottomLeft: Radius.circular(12),
                      //               bottomRight: Radius.circular(12),
                      //             ),
                      //           ),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: [
                      //               Container(
                      //                 margin: EdgeInsets.only(bottom: 10),
                      //                 child: Text(
                      //                   'widget.list[index].title',
                      //                   style: TextStyle(
                      //                       fontSize: 16,
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.bold),
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //               ),
                      //             ],
                      //           )),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
    //   child: Swiper(
    //     onIndexChanged: (index) {
    //       setState(() {
    //         _current = index;
    //       });
    //     },
    //     autoplay: false,
    //     layout: SwiperLayout.DEFAULT,
    //     itemCount: 2,
    //     itemBuilder: (BuildContext context, index) {
    //       return InkWell(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => DetailResource(
    //                 dataDetails: widget.list[index],
    //               ),
    //             ),
    //           );
    //         },
    //         child: Container(
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image:
    //                       NetworkImage(urlImage + widget.list[index].imageLink),
    //                   fit: BoxFit.fill),
    //               borderRadius: BorderRadius.circular(8),
    //               color: Colors.amber),
    //           padding: EdgeInsets.all(25),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Container(
    //                 child: Text(
    //                   '',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
