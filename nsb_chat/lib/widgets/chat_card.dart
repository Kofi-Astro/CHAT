import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/chat.dart';
import '../screens/contact/contact.dart';
import '../data/providers/chats_provider.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  ChatCard({
    super.key,
    required this.chat,
  });

  String? myId;

  var format = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    return InkWell(
      onTap: () {
        ChatsProvider chatsProvider =
            Provider.of<ChatsProvider>(context, listen: false);
        chatsProvider.setSelectedChat(chat);
        Navigator.of(context).pushNamed(ContactScreen.routeName);
      },
      child: Column(children: [
        // SenderFileCard(),
        // RecepientFileCard(),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/nsb_logo.png'),
            radius: 20,
          ),
          title: Text(
            // chat.otherUser!.username!,
            chat.user!.username!,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            const Icon(Icons.done_all),
            const SizedBox(
              width: 3,
            ),
            Text(
              chat.messages![0].message!,
              // chat.messages![chat.messages!.length - 1].text!,
              style: const TextStyle(fontSize: 13),
              maxLines: 2,
            ),
          ]),
          trailing: Column(
            children: [
              // Text(messageDate(chat.messages![0].sendAt!)),
              Text('00:00'),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                child: Text(
                  _numberOfUnreadMessagesByMe()! > 0
                      ? _numberOfUnreadMessagesByMe().toString()
                      : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  String messageDate(int milliseconds) {
    print("milliseconds $milliseconds");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return format.format(date);
  }

  int? _numberOfUnreadMessagesByMe() {
    return chat.messages?.where((message) => message.unreadByMe!).length;
  }

  Widget unreadMessages() {
    final unreadMessages = _numberOfUnreadMessagesByMe();
    if (unreadMessages == 0) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      color: Colors.blue,
      child: Text(
        unreadMessages.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}






    // return InkWell(
    //   onTap: () {
    //     // Navigator.of(context).pushNamed(
    //     //   ContactScreen.routeName,
    //     // );

    // ChatsProvider chatsProvider =
    //     Provider.of<ChatsProvider>(context, listen: false);
    // chatsProvider.setSelectedChat(chat.id!);
    // Navigator.of(context).pushNamed(ContactScreen.routeName);
    //   },

    //   child: Container(
    //     padding: const EdgeInsets.only(
    //       left: 15,
    //       top: 10,
    //       bottom: 0,
    //     ),
    //     child: Column(
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    // const CircleAvatar(
    //   backgroundImage: AssetImage('assets/images/nsb_logo.png'),
    //   radius: 20,
    // ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(
    //                   left: 15,
    //                   bottom: 3,
    //                 ),
    //                 child: Container(
    //                     child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: [
    // Text(
    //   chat.otherUser!.username!,
    //   style: const TextStyle(
    //       color: Colors.black,
    //       fontSize: 16,
    //       fontWeight: FontWeight.bold),
    // ),
    //                     const SizedBox(
    //                         // height: 2,
    //                         ),
    // Text(
    //   // chat.messages![0].text!,
    //   chat.messages![chat.messages!.length - 1].text!,
    //   style: const TextStyle(fontSize: 12),
    //   maxLines: 2,
    // ),
    //                     const SizedBox(
    //                       height: 15,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(right: 15, left: 30),
    //                       child: Column(
    //                         children: <Widget>[
    //                           Text(
    //                             messageDate(chat
    //                                 .messages![chat.messages!.length - 1]
    //                                 .createdAt!),
    //                             style: TextStyle(
    //                               color: Theme.of(context).primaryColor,
    //                               fontSize: 12,
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             height: 5,
    //                           ),
    // Container(
    //   padding: const EdgeInsets.symmetric(
    //       horizontal: 5, vertical: 0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(30),
    //     color: Colors.blue,
    //   ),
    //   child: const Text(
    //     '2',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 12,
    //     ),
    //   ),
    // ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       width: double.infinity,
    //                       height: 1,
    //                       color: const Color(0xffdddddd),
    //                     )
    //                   ],
    //                 )),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );