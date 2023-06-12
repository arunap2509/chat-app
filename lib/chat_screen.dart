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
  late TextEditingController textingController;

  @override
  void initState() {
    textingController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    textingController.dispose();
    super.dispose();
  }

  void _handleMessageInput() {
    textingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerColor,
      body: SafeArea(
        child: Column(
          children: [
            chatHeader(context),
            chatSpace(),
            chatInput(context),
          ],
        ),
      ),
    );
  }

  Container chatInput(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.white30,
          ),
        ),
      ),
      constraints: const BoxConstraints(
        maxHeight: 120,
      ),
      child: chatInputItems(context),
    );
  }

  Row chatInputItems(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 8,
        ),
        chatPhoneAccessorMenu(),
        const SizedBox(
          width: 8,
        ),
        chatInputField(context),
        const SizedBox(
          width: 8,
        ),
        if (textingController.text.isNotEmpty) chatSubmitBtn(context),
      ],
    );
  }

  Padding chatPhoneAccessorMenu() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.add,
          color: Colors.blue,
          size: 26,
          fill: 0.5,
        ),
      ),
    );
  }

  GestureDetector chatSubmitBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _handleMessageInput();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.send,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Padding chatInputField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            (textingController.text.isNotEmpty ? 0.75 : 0.85),
        child: TextField(
          onChanged: (value) {
            setState(() {});
          },
          // onEditingComplete: _handleMessageInput, this is a multiline keyboard, so it shows only return
          controller: textingController,
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            fillColor: Colors.blueGrey,
            filled: true,
            contentPadding: const EdgeInsets.all(4),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
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
          itemCount: 20,
          padding: const EdgeInsets.only(left: 12, bottom: 2, right: 12),
          reverse: true,
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
            chatHeaderUserInfo(context),
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

  Row chatHeaderUserInfo(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/naruto.jpeg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 3),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Text(
                "Online",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
