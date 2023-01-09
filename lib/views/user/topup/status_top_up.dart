// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:medico_app/models/reservation/loket_model.dart';
// import 'package:medico_app/models/user/topup_model.dart';
// import 'package:medico_app/providers/user/user_provider.dart';
// import 'package:medico_app/utils/message.dart';
// import 'package:medico_app/utils/transition.dart';
// import 'package:medico_app/views/dashboard_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TopUpScreen extends StatefulWidget {
//   final TopUpModel data;
//   final bool fromDashboard;
//   final int nominal;

//   //FOR STEP 2
//   final Loket? loket;
//   final String? customerId;
//   final String? email;

//   const TopUpScreen({
//     Key? key,
//     required this.data,
//     required this.fromDashboard,
//     required this.nominal,

//     //FOR STEP 2
//     this.loket,
//     this.customerId,
//     this.email,
//   }) : super(key: key);

//   @override
//   _TopUpScreenState createState() => _TopUpScreenState();
// }

// class _TopUpScreenState extends State<TopUpScreen> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
//     return JavascriptChannel(
//       name: 'Toaster',
//       onMessageReceived: (JavascriptMessage message) {
//         // ignore: deprecated_member_use
//         messageSnackBar(context, message.message);
//       },
//     );
//   }

//   Future<bool> _onWillPop() async {
//     return (await showDialog(
//           context: context,
//           builder: (context) => new AlertDialog(
//             title: new Text('Keluar halaman top up?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: new Text('No'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   if (widget.fromDashboard) {
//                     print(true);
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       generateSlideTransition(DashBoardScreen(
//                         selectedPage: 0,
//                       )),
//                       (route) => false,
//                     );
//                   } else {
//                     Navigator.pop(context, true);
//                   }
//                 },
//                 child: new Text('Yes'),
//               ),
//             ],
//           ),
//         )) ??
//         false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Top Up"),
//         centerTitle: true,
//       ),
//       body: WillPopScope(
//         onWillPop: _onWillPop,
//         child: WebView(
//           initialUrl: widget.data.object!.redirectUrl,
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             _controller.complete(webViewController);
//           },
//           onProgress: (int progress) {
//             print("WebView is loading (progress : $progress%)");
//           },
//           javascriptChannels: <JavascriptChannel>{
//             _toasterJavascriptChannel(context),
//           },
//           onPageStarted: (String url) {
//             print('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             context.refresh(userProviderData);
//             // Uri domain = Uri.parse(url);
//             // print(url);
//             if (url == "https://berlinetta.ptalia.co.id/acak/") {
//               if (widget.fromDashboard) {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   generateSlideTransition(DashBoardScreen(
//                     selectedPage: 0,
//                   )),
//                   (route) => false,
//                 );
//               } else {
//                 Navigator.pop(context, true);
//                 // Navigator.pushReplacement(
//                 //   context,
//                 //   generateScaleTransition(
//                 //     CreateStep2(
//                 //         customerId: widget.customerId!,
//                 //         email: widget.email!,
//                 //         loket: widget.loket!),
//                 //   ),
//                 // );
//               }
//             }

//             // print('Page finished loading: ${domain.host}');
//           },
//           onWebResourceError: (error) {
//             print(error);
//           },
//           gestureNavigationEnabled: true,
//         ),
//       ),
//     );
//   }
// }
