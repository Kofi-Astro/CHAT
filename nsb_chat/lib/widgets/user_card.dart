import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User? user;
  final Function? onTap;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(user!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 0,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/nsb_logo.png',
              ),
              radius: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                  bottom: 5,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        user!.username!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${user!.email}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xffdddddd),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
