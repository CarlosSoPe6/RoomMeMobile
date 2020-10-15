import 'package:flutter/material.dart';

class UserContactItem extends StatelessWidget {
  final String name;
  final String phone;
  final int index;

  UserContactItem(
      {@required this.name, @required this.phone, @required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                this.name,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                this.phone,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
      onLongPress: () => {},
    );
  }
}
