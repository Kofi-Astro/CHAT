import 'package:flutter/material.dart';

class RecepientMessageCard extends StatelessWidget {
  String? message;
  String? time;
  RecepientMessageCard({
    super.key,
    this.message,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 70,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          // color: Colors.lightBlueAccent,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 60,
                top: 5,
                bottom: 20,
              ),
              child: Text(
                message!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 10,
              child: Text(
                time!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
