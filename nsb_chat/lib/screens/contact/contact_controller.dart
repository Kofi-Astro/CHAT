import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nsb_chat/utils/custom_shared_preferences.dart';
import '../../models/message.dart';
import '../../models/chat.dart';
import 'package:provider/provider.dart';
import '../../data/providers/chats_provider.dart';

import '../../models/user.dart';
import '../../repositories/chat_repository.dart';
import '../../utils/state_control.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ContactController extends StateControl {
  BuildContext context;

  // Chat chat;
  late ChatsProvider _chatsProvider;
  // late Chat chat;
  Chat get selectedChat => _chatsProvider.selectedChat;

  late User myUser;

  ContactController({
    required this.context,
    // required this.chat,
  }) {
    init();
  }

  TextEditingController textEditingController = TextEditingController();

  // IO.Socket socket = SocketController.socket;
  final ChatRepository _chatRepository = ChatRepository();

  final bool _error = false;
  bool get error => _error;

  final bool _loading = true;
  bool get loading => _loading;

  @override
  void init() {
    initMyUser();
  }

  initMyUser() async {
    myUser = await getMyUser();
  }

  initProvider() async {
    _chatsProvider = Provider.of<ChatsProvider>(context);
  }

  getMyUser() async {
    final userString = await CustomSharedPreferences.get('user');
    final userJson = jsonDecode(userString);
    return User.fromJson(userJson);
  }

  sendMessage() async {
    final user = await CustomSharedPreferences.getMyUser();
    final myId = user.id;
    final selectedChat =
        Provider.of<ChatsProvider>(context, listen: false).selectedChat;

    final to = selectedChat.user!.id;
    final message = textEditingController.text;
    final newMessage = Message(
        chatId: selectedChat.id,
        from: myId,
        to: to,
        message: message,
        sendAt: DateTime.now().millisecondsSinceEpoch,
        unreadByMe: false);

    textEditingController.text = '';
    await Provider.of<ChatsProvider>(context, listen: false)
        .addMessageToChat(newMessage);
    await _chatRepository.sendMessage(message, to!);
  }

  // void initProvider() {
  //   _chatsProvider = Provider.of<ChatsProvider>(context);
  //   chat = _chatsProvider.chats
  //       .firstWhere((chat) => chat.id == _chatsProvider.selectedChatId);
  // }
  // }

  // void sendAttachment() {}

  // void sendMessage() {
  //   String text = textEditingController.text;
  //   if (text.isEmpty) return;
  //   _chatRepository.sendMessage(chat.id!, text);
  //   // addMessage(text);
  //   textEditingController.text = '';
  //   // notifyListeners();

  //   Message message = Message(
  //     text: text,
  //     userId: chat.myUser!.id,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     unreadByMe: false,
  //     unreadByOtherUser: true,
  //   );
  //   // print(message);
  //   addMessage(message);
  // }

  // void addMessage(Message message) {
  //   // print(message.userId);
  //   // chat.messages!.add(message);
  //   // notifyListeners();
  //   _chatsProvider.addMessageToSelectedChat(message);
  // }

  @override
  void dispose() {
    super.dispose();
    var textEditingController;
    textEditingController.dispose();
    _chatsProvider.setSelectedChat(null);
    // disconnectSocket();
  }
}
