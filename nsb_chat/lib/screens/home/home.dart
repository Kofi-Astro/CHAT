import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsb_chat/screens/add_chat/add_chat.dart';

import '../calls/calls.dart';
import './home_controller.dart';
import '../../widgets/chat_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeController _homeController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context: context);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
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
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text('NSB CHAT'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  PopupMenuButton(
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 'New group',
                            child: Text('New group'),
                          ),
                          const PopupMenuItem(
                            value: 'New broadcast',
                            child: Text('New broadcast'),
                          ),
                          const PopupMenuItem(
                            value: 'NSB Chat web',
                            child: Text('NSB Chat web'),
                          ),
                          const PopupMenuItem(
                            value: 'Starred messages',
                            child: Text('Starred messages'),
                          ),
                          const PopupMenuItem(
                            value: 'Settings',
                            child: Text('Settings'),
                          ),
                          PopupMenuItem(
                            value: 'Logout',
                            child: Text('Logout'),
                            onTap: _homeController.logout,
                          )
                        ];
                      })
                ],
                bottom: TabBar(controller: _tabController, tabs: const [
                  Tab(
                    text: 'Chat',
                  ),
                  Tab(
                    text: 'Users',
                  ),
                  Tab(
                    text: 'Calls',
                  )
                ]),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  usersList(context),
                  AddChatScreen(),
                  CallsPage(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {}, // _homeController.openAddChatScreen,
                child: const Icon(Icons.add),
              ));
        });
  }

  Widget usersList(BuildContext context) {
    if (_homeController.loading) {
      return Container(
        child: Center(child: CupertinoActivityIndicator()),
      );
    }

    if (_homeController.error) {
      return Container(
        child: Center(child: Text('Error occurred while fetching chats')),
      );
    }

    bool chatsWithMessages = _homeController.chats.any((chat) {
      return chat.messages?.isNotEmpty ?? false;
    });

    if (!chatsWithMessages) {
      return Container(
        child: Center(child: Text('No chats exist')),
      );
    }

    // return SliverPadding(
    //   padding: const EdgeInsets.symmetric(vertical: 10),
    //   sliver: SliverList(
    //     delegate: SliverChildBuilderDelegate(
    //       (BuildContext context, int index) {
    //         return Column(
    //           children: _homeController.chats.map((chat) {
    //             if (chat.messages!.isEmpty) {
    //               return const SizedBox(
    //                 height: 0,
    //                 width: 0,
    //               );
    //             }
    //             return Column(
    //               children: [
    //                 ChatCard(chat: chat),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //               ],
    //             );
    //           }).toList(),
    //         );
    //       },
    //       childCount: 1,
    //     ),
    //   ),
    // );

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: _homeController.chats.length,
      itemBuilder: (BuildContext context, int index) {
        final chat = _homeController.chats[index];
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
      },
    );
  }
}
