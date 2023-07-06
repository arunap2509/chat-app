import 'dart:math';

import 'package:chat_like_app/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var showTabBarTitle = false;
  final dummyNames = ["Arun AP", "Jessica", "Jordan", "Chris"];
  final random = Random(42);

  void handleShowTabBarTitle(bool isVisible) {
    setState(() {
      showTabBarTitle = isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    VisibilityDetectorController.instance.forget(const Key("chat-app-header"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: showTabBarTitle ? headerColor : Colors.black,
        title: Opacity(
          opacity: showTabBarTitle ? 1 : 0,
          child: const Text(
            "Chats",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Text(
            "Edit",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          splashRadius: 1,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.comment_outlined,
              color: Colors.blue,
              size: 20,
            ),
            splashRadius: 1,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              chatHeader(),
              const SizedBox(
                height: 4,
              ),
              groupCreationBtn(),
              const SizedBox(
                height: 4,
              ),
              horizontalDivider(double.infinity),
              getChatListView()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: "Chats",
              icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            ),
            BottomNavigationBarItem(
              label: "Calls",
              icon: Icon(CupertinoIcons.phone),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
          backgroundColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedItemColor: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget chatHeader() {
    return VisibilityDetector(
      key: const Key("chat-app-header"),
      onVisibilityChanged: (info) {
        var visiblePercentage = info.visibleFraction * 100;
        handleShowTabBarTitle(visiblePercentage == 0);
      },
      child: Row(
        children: const [
          Text(
            "Chats",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Row groupCreationBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: const Text(
            "New Group",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }

  Widget getChatListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 4,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var maxWidth = MediaQuery.of(context).size.width;
        var dummyName = dummyNames[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/chat',
              arguments: {'userName': dummyName},
            );
          },
          child: Container(
            width: double.infinity,
            height: 75,
            margin: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                chatAvatar(),
                chatPreview(maxWidth, index, dummyName),
              ],
            ),
          ),
        );
      },
    );
  }

  Container chatPreview(double maxWidth, int index, String name) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          firstRow(maxWidth, index, name),
          const SizedBox(
            height: 6,
          ),
          secondRow(maxWidth, index),
          const SizedBox(
            height: 6,
          ),
          horizontalDivider((maxWidth - 70) * 0.9),
        ],
      ),
    );
  }

  Row firstRow(double maxWidth, int index, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (maxWidth - 70) * 0.75,
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          index % 2 == 0 ? "Yesterday" : "8:49 PM",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: index % 2 == 0 ? Colors.white38 : Colors.blue,
          ),
        )
      ],
    );
  }

  Row secondRow(double maxWidth, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (maxWidth - 70) * 0.80,
          child: Text(
            "hey there, long time no see, acvhlshlvbldbvfblbvbvlbvsvdbvlbblfblfbvbvbvfsdvlbfsvjbffrbzdbsbbljb",
            style: TextStyle(
              color: (index % 2 != 0) ? Colors.blue : Colors.white54,
              fontWeight: (index % 2 != 0) ? FontWeight.w500 : FontWeight.w300,
              fontSize: 13,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (index % 2 != 0)
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "99",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Container horizontalDivider(double width) {
    return Container(
      height: 1,
      width: width,
      color: Colors.white12,
    );
  }

  Container chatAvatar() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          "A",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Row actionBtnHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // check if you can change the animation when the button is clicked
        GestureDetector(
          onTap: () {},
          child: const Text(
            "Edit",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.comment_outlined,
            color: Colors.blue,
            size: 20,
          ),
        )
      ],
    );
  }
}
