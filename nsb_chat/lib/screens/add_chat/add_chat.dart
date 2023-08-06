import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/user_card.dart';
import './add_chat_controller.dart';

class AddChatScreen extends StatefulWidget {
  static const String routeName = '/add-chat';

  const AddChatScreen({super.key});

  @override
  State<AddChatScreen> createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  late AddChatController _addChatController;

  @override
  void initState() {
    super.initState();

    _addChatController = AddChatController(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
        stream: _addChatController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: CustomScrollView(slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text(
                  'Users',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              renderusers(),
            ]),
          );
        });
  }

  Widget renderusers() {
    if (_addChatController.loading) {
      return const SliverFillRemaining(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    if (_addChatController.error) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('Error occured fetching users'),
        ),
      );
    }

    if (_addChatController.users.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No users found'),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Column(
              children: _addChatController.users.map((user) {
                return Column(
                  children: [
                    UserCard(
                      user: user,
                      onTap: _addChatController.newChat,
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

    // return ListView(
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 10,
    //     horizontal: 10,
    //   ),
    //   children: _addChatController.users.map((user) {
    //     return Column(
    //       children: [
    //         UserCard(
    //           user: user,
    //           onTap: _addChatController.newChat,
    //           // onTap: () {
    //           //   Navigator.of(context).pushNamed(ContactScreen.routeName);
    //           // },
    //         ),
    //         const SizedBox(
    //           height: 5,
    //         ),
    //       ],
    //     );
    //   }).toList(),
    // );
  }
}
