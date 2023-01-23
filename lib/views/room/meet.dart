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
import 'package:tozoom/tozoom.dart';
import 'package:tozoom/tozoom_options.dart';
import 'package:tozoom/tozoom_view.dart';

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
    print(context);
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
    if (meetingIdController.text.isNotEmpty) {
      print('hai');
      bool _isMeetingEnded(String status) {
        var result = false;

        if (Platform.isAndroid) {
          result = status == "MEETING_STATUS_DISCONNECTING" ||
              status == "MEETING_STATUS_FAILED";
        } else {
          result = status == "MEETING_STATUS_IDLE";
        }

        return result;
      }

      ZoomOptions zoomOptions = ZoomOptions(
        domain: "zoom.us",
        appKey: "fUjmn4sIrkO5Xr2fTmI8K4Priyi1TxEd4BlK", //API KEY FROM ZOOM
        appSecret:
            "Ty2SXmxJyTJQGdJELUbrzyCuqVEbDH32M55K", //API SECRET FROM ZOOM
      );
      var meetingOptions = ZoomMeetingOptions(
          userId: 'username',

          /// pass username for join meeting only --- Any name eg:- EVILRATT.
          meetingId: meetingIdController.text,

          /// pass meeting password for join meeting only
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          disableTitlebar: "false",
          viewOptions: "true",
          noAudio: "false",
          noDisconnectAudio: "false");

      var zoom = ZoomView();

      zoom.initZoom(zoomOptions).then((result) {
        print("result");
        if (result[0] == 0) {
          zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
            timer = Timer.periodic(const Duration(seconds: 2), (timer) {
              zoom.meetingStatus(meetingOptions.meetingId!).then((status) {
                if (kDebugMode) {
                  print("[Meeting Status Polling] : " +
                      status[0] +
                      " - " +
                      status[1]);
                }
              });
            });
          });
        }
      });
    } else {
      if (meetingIdController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Fill Meeting ID!"),
        ));
      }
    }
  }
}
