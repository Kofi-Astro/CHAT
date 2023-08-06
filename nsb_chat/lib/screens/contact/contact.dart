import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/chats_provider.dart';

import '../../widgets/recepient_message.dart';
import '../../widgets/sender_message.dart';
import './contact_controller.dart';
import '../../models/chat.dart';
import '../../models/message.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact';

  const ContactScreen({
    super.key,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactController _contactController;

  final ScrollController _scrollController = ScrollController();
  bool showEmoji = false;

  bool sendButton = false;

  @override
  void initState() {
    super.initState();

    _contactController = ContactController(
      context: context,
    );
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _contactController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _contactController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: const Color(0xffeeeeeeee),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                leadingWidth: 70,
                titleSpacing: 0,
                leading:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: Image.asset(
                      'assets/images/nsb_logo.png',
                      width: 37,
                    ),
                  )
                ]),
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _contactController.chat.otherUser!.username!,
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'last seen today at 00:00',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.videocam,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                    ),
                  ),
                  PopupMenuButton(
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 'View Contact',
                            child: Text('View Contact'),
                          ),
                          const PopupMenuItem(
                            value: 'Media, links and docs',
                            child: Text('Media, links and docs'),
                          ),
                          const PopupMenuItem(
                            value: 'NSB Chat web',
                            child: Text('NSB Chat web'),
                          ),
                          const PopupMenuItem(
                            value: 'Search',
                            child: Text('Search'),
                          ),
                          const PopupMenuItem(
                            value: 'Mute Notification',
                            child: Text('Mute Notification'),
                          ),
                          const PopupMenuItem(
                            value: 'Wallpaper',
                            child: Text('Wallpaper'),
                          )
                        ];
                      })
                ],
              ),
            ),
            body: SafeArea(
                child: Container(
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: _contactController.chat.messages!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = _contactController.chat.messages![index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 5,
                        ),
                        child:
                            message.userId == _contactController.chat.myUser!.id
                                ? SenderMessageCard(
                                    message: message.text,
                                    time: message.createdAt.toString(),
                                  )
                                : RecepientMessageCard(
                                    message: message.text,
                                    time: message.createdAt.toString(),
                                  ),
                      );
                    },
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 55,
                      child: Row(children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      // TextField(
                                      //   autocorrect: false,
                                      //   cursorColor: Theme.of(context).primaryColor,
                                      //   controller:
                                      //       _contactController.textEditingController,
                                      //   onSubmitted: (_) {
                                      //     _contactController.sendMessage();
                                      //   },
                                      //   decoration: const InputDecoration(
                                      //     contentPadding: EdgeInsets.only(bottom: 0),
                                      //     hintText: 'Type a message',
                                      //     hintStyle: TextStyle(fontSize: 16),
                                      //     border: InputBorder.none,
                                      //   ),
                                      // ),
                                      TextFormField(
                                    controller: _contactController
                                        .textEditingController,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type a message',
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        prefixIcon: const IconButton(
                                            icon: Icon(Icons.emoji_emotions),
                                            onPressed: null),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomSheet());
                                                },
                                                icon: const Icon(
                                                  Icons.attach_file,
                                                )),
                                            const Icon(Icons.camera_alt),
                                          ],
                                        )),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 25,
                            child: sendButton
                                ? IconButton(
                                    onPressed: _contactController.sendMessage,
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                  ),
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              ]),
            )),
          );
        });
  }

  iconCreation({
    IconData? icon,
    Color? color,
    String? text,
    required Function(BuildContext) onPressed,
  }) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: IconButton(
            icon: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
            onPressed: () => onPressed(context),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text!,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Future<void> clickCamera(BuildContext context) async {}
  Future<void> clickGallery(BuildContext context) async {}
  Future<void> clickLocation(BuildContext context) async {}
  Future<void> clickAudio(BuildContext context) async {}
  Future<void> clickContact(BuildContext context) async {}

  Future<void> clickDocument(BuildContext context) async {}

  bottomSheet() {
    return SizedBox(
      height: 278,
      child: Column(
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconCreation(
                        icon: Icons.insert_drive_file,
                        color: Colors.indigo,
                        text: 'Document',
                        onPressed: (context) => clickDocument(context),
                      ),
                      iconCreation(
                        icon: Icons.camera_alt_sharp,
                        color: Colors.pinkAccent,
                        text: 'Image',
                        onPressed: (context) => clickCamera(context),
                      ),
                      iconCreation(
                        icon: Icons.insert_drive_file,
                        color: Colors.purple,
                        text: 'Gallery',
                        onPressed: (context) => clickGallery(context),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconCreation(
                        icon: Icons.headset,
                        color: Colors.amber,
                        text: 'Audio',
                        onPressed: (context) => clickAudio(context),
                      ),
                      iconCreation(
                        icon: Icons.location_on,
                        color: Colors.green,
                        text: 'Location',
                        onPressed: (context) => clickLocation(context),
                      ),
                      iconCreation(
                        icon: Icons.person,
                        color: Colors.blue,
                        text: 'Contact',
                        onPressed: (context) => clickContact(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ))
        ],
      ),
    );
  }
}
