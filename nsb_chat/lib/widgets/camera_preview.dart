import 'dart:io';

import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatelessWidget {
  static const routeName = '/camera_preview';
  final String? path;
  final Function? onImageSend;
  const CameraPreviewScreen({
    super.key,
    this.path,
    this.onImageSend,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_rotate,
              size: 27,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 27,
              )),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 150,
            child: Image.file(
              File(path!),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black38,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                controller: controller,
                maxLines: 6,
                minLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  hintText: 'Add Caption .....',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  prefix: const Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 27,
                  ),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.tealAccent[700],
                    child: InkWell(
                      onTap: () {
                        controller.text ??= '';

                        onImageSend!(
                          path,
                          controller.text.trim(),
                        );
                      },
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
