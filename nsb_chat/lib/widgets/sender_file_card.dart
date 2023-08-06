import 'dart:io';

import 'package:flutter/material.dart';

class SenderFileCard extends StatefulWidget {
  final String? path;
  final String? message;
  final String? time;
  const SenderFileCard({super.key, this.path, this.message, this.time});

  @override
  State<SenderFileCard> createState() => _SenderFileCardState();
}

class _SenderFileCardState extends State<SenderFileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: Colors.green[300],
          ),
          child: Card(
            margin: const EdgeInsets.all(3),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  // flex: 9,
                  child: Image.file(
                    File(widget.path!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(
                  widget.message!,
                  style: const TextStyle(),
                ),
                Text(widget.time!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
