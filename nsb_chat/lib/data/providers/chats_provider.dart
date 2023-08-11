import 'package:flutter/material.dart';
import 'package:nsb_chat/data/local_database/db_provider.dart';
import '../../models/user.dart';
import '../../repositories/chat_repository.dart';

import '../../models/chat.dart';
import '../../models/message.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  final ChatRepository _chatRepository = ChatRepository();

  late Chat _selectedChat;
  Chat get selectedChat => _selectedChat;

  // setChats(List<Chat> chats) {
  // _chats = chats;
  updateChats() async {
    List<Chat> newChats = await DBProvider.db.getChatWithMessages();
    newChats.sort(
      (a, b) {
        if (a.messages!.isEmpty) return 1;
        if (b.messages!.isEmpty) return -1;

        int millisecondsA = a.messages![a.messages!.length - 1].sendAt!;
        int millisecondsB = b.messages![b.messages!.length - 2].sendAt!;

        return millisecondsA > millisecondsB ? -1 : 1;
      },
    );
    _chats = newChats;

    notifyListeners();
  }

  // setSelectedChat(Chat selectedChatId) async {
  //   _selectedChat = selectedChatId!;
  //   notifyListeners();
  //   _selectedChat.messages =
  //       await DBProvider.db.getChatMessages(selectedChatId.id!);
  //   print('messages: ${_selectedChat.messages!.length}');
  //   _readSelectedChatMessages();

  //   // _chatRepository.readChat(_selectedChatId);
  //   notifyListeners();
  // }

  void setSelectedChat(Chat? selectedChatId) async {
    if (selectedChatId == null) {
      return;
    }

    _selectedChat = selectedChatId;
    notifyListeners();

    if (_selectedChat.messages == null) {
      _selectedChat.messages =
          await DBProvider.db.getChatMessages(selectedChatId.id!);
      print('messages: ${_selectedChat.messages!.length}');
      _readSelectedChatMessages();
    }

    notifyListeners();
  }

  _readSelectedChatMessages() async {
    // _selectedChat.messages = _selectedChat.messages?.map((message) {
    //   message.unreadByMe = false;
    //   return message;
    // }).toList();

    // List<Chat> updatedChats = _chats;
    // updatedChats = updatedChats.map((chat) {
    //   if (chat.id == _selectedChatId) {
    //     chat.messages = chat.messages?.map((message) {
    //       message.unreadByMe = false;
    //       return message;
    //     }).toList();
    //   }
    //   return chat;
    // }).toList();

    // // updateSelectedChatInChats();

    // setChats(updatedChats);

    await DBProvider.db.readChatMessages(_selectedChat.id!);
    updateChats();
  }

  addMessageToSelectedChat(Message message) {
    //   _selectedChat.messages?.add(message);
    //   // setChats(_chats);
    //   updateSelectedChatInChats();
    // }

    // updateSelectedChatInChats() {
    //   List<Chat> newChats = _chats.map((chat) {
    //     if (chat.id == _selectedChat.id!) {
    //       chat = _selectedChat;
    //     }
    //     return chat;
    //   }).toList();
    //   setChats(newChats);

    // List<Chat> updatedChats = _chats;
    // updatedChats = updatedChats.map((chat) {
    //   if (chat.id == _selectedChatId) {
    //     chat.messages?.add(message);
    //   }
    //   return chat;
    // }).toList();

    // setChats(updatedChats);

    DBProvider.db.addMessage(message);
    updateChats();
  }

  createUserIfNotExists(User user) async {
    await DBProvider.db.createUserIfNotExists(user);
    updateChats();
  }

  createChatIfNotExists(Chat chat) async {
    await DBProvider.db.createChatIfNotExists(chat);
    updateChats();
  }

  createChatAndUserIfNotExists(Chat chat) async {
    await DBProvider.db.createUserIfNotExists(chat.user!);
    await DBProvider.db.createChatIfNotExists(chat);
    updateChats();
  }

  addMessageToChat(Message message) async {
    await DBProvider.db.addMessage(message);
    updateChats();
    setSelectedChat(selectedChat);
  }
}
