import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './home_controller.dart';
import '../../widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context: context);
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _homeController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _homeController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
              body: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: const Text(
                      'Chats',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: _homeController.logout,
                          icon: const Icon(Icons.exit_to_app)),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  usersList(context),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _homeController.openAddChatScreen,
                child: const Icon(Icons.add),
              ));
        });
  }

  Widget usersList(BuildContext context) {
    if (_homeController.loading) {
      return const SliverFillRemaining(
        child: Center(child: CupertinoActivityIndicator()),
      );
    }

    if (_homeController.error) {
      return const SliverFillRemaining(
        child: Center(child: Text('Error occurred while fetching chats')),
      );
    }

    bool chatsWithMessages = _homeController.chats.any((chat) {
      return chat.messages?.isNotEmpty ?? false;
    });

    if (!chatsWithMessages) {
      return const SliverFillRemaining(
        child: Center(child: Text('No chats exist')),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              children: _homeController.chats.map((chat) {
                if (chat.messages!.isEmpty) {
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }
                return Column(
                  children: [
                    ChatCard(chat: chat),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                );
              }).toList(),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }
}
