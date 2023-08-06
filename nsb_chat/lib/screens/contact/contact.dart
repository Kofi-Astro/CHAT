import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/chats_provider.dart';

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
            // appBar: AppBar(
            //     title: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       _contactController.chat.otherUser!.username!,
            //       style: const TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //     renderOnline(),
            //   ],
            // )),
            appBar: CupertinoNavigationBar(
              middle: Text(
                _contactController.chat.otherUser!.username!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color(0Xfff8f8f8),
            ),
            body: SafeArea(
                child: Container(
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: _contactController.chat.messages!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final reverseIndex =
                          _contactController.chat.messages!.length - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 5,
                        ),
                        child: renderMessages(
                            context,
                            // _contactController.chat.messages![reverseIndex]
                            _contactController.chat.messages![index]),
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
                                child: TextField(
                                  autocorrect: false,
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller:
                                      _contactController.textEditingController,
                                  onSubmitted: (_) {
                                    _contactController.sendMessage();
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 0),
                                    hintText: 'Type a message',
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            onTap: _contactController.sendMessage,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
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

  Widget renderMessages(BuildContext context, Message message) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Align(
            alignment: message.userId == _contactController.chat.myUser!.id
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
                color: message.userId == _contactController.chat.myUser!.id
                    ? const Color(0xFFC0CBFF)
                    : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    message.text!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

  // Widget renderOnline() {
  //   // if (_contactController!.chatOnlineInMyChat) {
  //   //   return const Text(
  //   //     'online in your conversation',
  //   //     style: TextStyle(
  //   //         fontSize: 12,
  //   //         fontWeight: FontWeight.bold,
  //   //         color: Colors.greenAccent),
  //   //   );
  //   // }
  //   return const SizedBox(
  //     width: 0,
  //     height: 0,
  //   );
  // }

