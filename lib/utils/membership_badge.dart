import 'package:flutter/material.dart';
import 'package:medico_app/utils/helpers.dart';

class MembershipWidget extends StatelessWidget {
  final String membership;
  const MembershipWidget({
    Key? key,
    required this.membership,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
        color: getColorMembership(membership),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        membership,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
