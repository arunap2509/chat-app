import 'package:chat_like_app/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_box.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({super.key, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerColor,
      body: SafeArea(
        child: Column(
          children: [
            chatHeader(context),
            chatSpace(),
            Container(
              height: 50,
              width: double.maxFinite,
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget chatSpace() {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.only(left: 12, bottom: 2, right: 12),
          itemBuilder: (context, index) {
            return ChatBox(type: index % 2 == 0 ? "sent" : "received");
          },
        ),
      ),
    );
  }

  Widget chatHeader(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const SizedBox(
                height: 30,
                width: 30,
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.only(right: 8),
              child: const Icon(
                CupertinoIcons.phone,
                size: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
