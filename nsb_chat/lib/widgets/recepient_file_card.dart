
import 'package:flutter/material.dart';

class RecepientFileCard extends StatefulWidget {
  final String? path;
  final String? message;
  final String? time;
  const RecepientFileCard({super.key, this.path, this.message, this.time,});

  @override
  State<RecepientFileCard> createState() => _RecepientFileCardState();
}

class _RecepientFileCardState extends State<RecepientFileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: Colors.grey[300],
          ),
          child: Card(
            margin: const EdgeInsets.all(3),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
              children: [
                Image.network(
                  'http://172.168.1.106:5000/uploads/${widget.path}',
                  fit: BoxFit.fitHeight,
                ),
                Text(widget.message!, style: const TextStyle(),),
                Text(widget.time!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
