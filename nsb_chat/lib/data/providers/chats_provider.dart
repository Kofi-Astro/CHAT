import 'package:flutter/material.dart';
import '../../repositories/chat_repository.dart';

import '../../models/chat.dart';
import '../../models/message.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  final ChatRepository _chatRepository = ChatRepository();

  late String _selectedChatId;
  String get selectedChatId => _selectedChatId;

  setChats(List<Chat> chats) {
    // _chats = chats;

    List<Chat> newChats = List<Chat>.from(chats);
    newChats.sort(
      (a, b) {
        if (a.messages!.isEmpty) return 1;
        if (b.messages!.isEmpty) return -1;

        int millisecondsA = a.messages![a.messages!.length - 1].createdAt!;
        int millisecondsB = b.messages![b.messages!.length - 2].createdAt!;

        return millisecondsA > millisecondsB ? -1 : 1;
      },
    );
    _chats = newChats;

    notifyListeners();
  }

  setSelectedChat(String selectedChatId) {
    _selectedChatId = selectedChatId;
    _readSelectedChatMessages();
    _chatRepository.readChat(_selectedChatId);
    notifyListeners();
  }

  _readSelectedChatMessages() {
    // _selectedChat.messages = _selectedChat.messages?.map((message) {
    //   message.unreadByMe = false;
    //   return message;
    // }).toList();

    List<Chat> updatedChats = _chats;
    updatedChats = updatedChats.map((chat) {
      if (chat.id == _selectedChatId) {
        chat.messages = chat.messages?.map((message) {
          message.unreadByMe = false;
          return message;
        }).toList();
      }
      return chat;
    }).toList();

    // updateSelectedChatInChats();

    setChats(updatedChats);
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

    List<Chat> updatedChats = _chats;
    updatedChats = updatedChats.map((chat) {
      if (chat.id == _selectedChatId) {
        chat.messages?.add(message);
      }
      return chat;
    }).toList();

    setChats(updatedChats);
  }
}
