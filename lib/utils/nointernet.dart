import 'package:flutter/material.dart';

class ReloadInternet extends StatefulWidget {
  final VoidCallback reload;
  final String message;

  ReloadInternet({required this.reload, required this.message});
  @override
  _ReloadInternetState createState() => _ReloadInternetState();
}

class _ReloadInternetState extends State<ReloadInternet> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isloading
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFBff0f7b),
                ),
                child: Text(
                  "reload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
