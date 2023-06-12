import 'package:flutter/material.dart';
import 'package:medico_app/utils/styles.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.labelText,
  }) : super(key: key);

  final Function() onPressed;
  final Widget icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  )
                ]),
            child: Center(child: icon),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
