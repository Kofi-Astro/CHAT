import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../utils/socket_controller.dart';
import 'package:provider/provider.dart';

import '../../data/providers/chats_provider.dart';
import '../../models/user.dart';
import '../../utils/custom_shared_preferences.dart';
import '../login/login.dart';
import '../../models/chat.dart';
import '../../models/custom_error.dart';
import '../../repositories/chat_repository.dart';
import '../../screens/add_chat/add_chat.dart';
import '../../utils/state_control.dart';

class HomeController extends StateControl {
  final BuildContext context;

  HomeController({required this.context}) {
    init();
  }

  final ChatRepository _chatRepository = ChatRepository();
  IO.Socket socket = SocketController.socket;
  late ChatsProvider _chatsProvider;

  bool _error = false;
  bool get error => _error;

  bool _loading = true;
  bool get loading => _loading;

  final List<User> _users = [];
  List<User> get users => _users;

  // List<Chat> _chats = [];
  // List<Chat> get chats => _chats;
  List<Chat> get chats => _chatsProvider.chats;

  @override
  void init() {
    getChats();
    initSocket();
  }

  void initProvider() {
    _chatsProvider = Provider.of<ChatsProvider>(context);
  }

  void initSocket() {
    emitUserIn();
    onMessage();
  }

  void emitUserIn() async {
    User user = await getUserFromSharedPreferences();
    Map<String, dynamic> json = user.toJson();
    socket.emit('user-in', json);
  }

  void onMessage() async {
    socket.on('message', (dynamic data) async {
      Map<String, dynamic> json = data;

      // Map<String, dynamic> json = jsonDecode(data);
      Chat chat = Chat.fromJson(json);

      // int chatIndex = _chats.indexWhere((_chat) => _chat.id == chat.id);

      int chatIndex = chats.indexWhere((chat) => chat.id == chat.id);
      List<Chat> newChats = List<Chat>.from(chats);

      if (chatIndex > -1) {
        // _chats[chatIndex].messages = chat.messages;
        newChats[chatIndex].messages = chat.messages;
        newChats[chatIndex] = await newChats[chatIndex].formatChat();
      } else {
        newChats.add(await chat.formatChat());
      }

      _chatsProvider.setChats(newChats);
      for (var chat in _chatsProvider.chats) {
        if (chat.id == _chatsProvider.selectedChatId) {
          _chatsProvider.setSelectedChat(chat.id!);
          continue;
        }
      }

      _chatsProvider.setChats(newChats);
    });
  }

  void emitUserLeft() async {
    socket.emit("user-left");
  }

  void getChats() async {
    final dynamic chatResponse = await _chatRepository.getChats();

    if (chatResponse is CustomError) {
      print('Error: ${chatResponse.error}');
      _error = true;
    }

    if (chatResponse is List<Chat>) {
      List<Chat> chats = await formatChats(chatResponse);
    }

    _loading = false;
    notifyListeners();
  }

  Future<List<Chat>> formatChats(List<Chat> chats) async {
    return await Future.wait(chats.map((chat) => chat.formatChat()));
  }

  int calculateChatsWithMessages() {
    print('calling ${chats.where((chat) => chat.messages!.isNotEmpty).length}');

    return chats.where((chat) => chat.messages!.isNotEmpty).length;
  }

  Future<User> getUserFromSharedPreferences() async {
    final savedUser = await CustomSharedPreferences.get('user');
    User user = User.fromJson(jsonDecode(savedUser));
    return user;
  }

  void logout() async {
    emitUserLeft();
    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  void openAddChatScreen() {
    Navigator.of(context).pushNamed(AddChatScreen.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    emitUserLeft();
  }
}
