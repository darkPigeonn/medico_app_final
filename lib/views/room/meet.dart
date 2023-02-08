import 'dart:async';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:soluspopulinew/ui/homepage.dart';
import 'package:flutter/material.dart';

import '../../utils/request_util.dart';

// class RoomScreen extends StatelessWidget {
//   String _idPasien;
//   RoomScreen(this._idPasien);
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('formUpdate')
//                 .doc(_idPasien)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               DocumentSnapshot? userDocument =
//                   snapshot.data as DocumentSnapshot?;
//               // DocumentSnapshot? userDocument =
//               //     snapshot.data as DocumentSnapshot<Object>?;
//               String? status = userDocument?.get("roomStatus");
//               String? roomId = userDocument?.get("roomId");
//               String? roomPassword = userDocument?.get("roomPassword");
//               print(roomId);
//               print(roomPassword);

//               if (status == "tertutup") {
//                 return new CircularProgressIndicator();
//               }
//               if (status == "terbuka") {
//                 return new Meeting2(roomId: roomId, roomPassword: roomPassword);
//               }

//               return new HomePage();
//             }),
//       ),
//     );
//   }
// }

class Meeting2 extends StatefulWidget {
  final Map? signature;

  Meeting2({Key? key, this.signature}) : super(key: key);

  @override
  _MeetingState2 createState() => _MeetingState2();
}

class _MeetingState2 extends State<Meeting2> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    permissionStart();
  }

  permissionStart() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    urlZoom + '?id=75149303963&pass=sZ1ZST&title=coba')),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            }),
      ),
    ]));
  }
}
// Join Zoom Meeting
// https://us04web.zoom.us/j/75149303963?pwd=ej038VwfXYT4W9ckDLpite6g1cOtck.1

// Meeting ID: 751 4930 3963
// Passcode: sZ1ZST



