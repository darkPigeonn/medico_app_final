import 'dart:async';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:soluspopulinew/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_sdk/zoom_options.dart';
import 'package:flutter_zoom_sdk/zoom_view.dart';

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

  Future<void> _launchBrowser(String url) async {
    print(url);
    if (!await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'})) {
      throw 'Could not launch $url';
    }
    ;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              joinMeeting(context);
            },
            child: Text(
              "Silahkan masuk ruangan",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue)),
          ),
        ),
      ),
    );
  }

  joinMeeting(BuildContext context) {
    // String? roomId = widget.signature['meetingdId'];
    // String? roomPassword = widget.roomPassword;

    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid)
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      else
        result = status == "MEETING_STATUS_IDLE";

      return result;
    }

    if (widget.signature!['meetingId'].toString().isNotEmpty &&
        widget.signature!['meetingPassword'].toString().isNotEmpty) {
      ZoomOptions zoomOptions = new ZoomOptions(
          domain: "zoom.us", appKey: widget.signature!['signature']
          // appKey: "XKE4uWfeLwWEmh78YMbC6mqKcF8oM4YHTr9I", //API KEY FROM ZOOM
          // appSecret:
          //     "bT7N61pQzaLXU6VLj9TVl7eYuLbqAiB0KAdb", //API SECRET FROM ZOOM
          );
      var meetingOptions = new ZoomMeetingOptions(
          userId:
              'username', //pass username for join meeting only --- Any name eg:- EVILRATT.
          meetingId: widget
              .signature!['meetingId'], //pass meeting id for join meeting only
          meetingPassword: widget.signature![
              'meetingPassword'], //pass meeting password for join meeting only
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          disableTitlebar: "false",
          viewOptions: "true",
          noAudio: "false",
          noDisconnectAudio: "false");

      var zoom = ZoomView();
      zoom.initZoom(zoomOptions).then((results) {
        if (results[0] == 0) {
          zoom.onMeetingStatus().listen((status) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
            if (_isMeetingEnded(status[0])) {
              print("[Meeting Status] :- Ended");
              timer.cancel();
            }
          });
          print("listen on event channel");
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(new Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                print("[Meeting Status Polling] : " +
                    status[0] +
                    " - " +
                    status[1]);
              });
            });
          });
        }
      }).catchError((error) {
        print("[Error Generated] : " + error);
      });
    }
  }
}
