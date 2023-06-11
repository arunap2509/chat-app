import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String type;
  const ChatBox({super.key, this.type = 'received'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: type == 'sent'
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (type == 'received')
                ClipPath(
                  clipper: CustomBottomLeftClipPath(),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: 12,
                    width: 12,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: type == 'sent'
                        ? Radius.zero
                        : const Radius.circular(10),
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: type == 'sent'
                        ? const Radius.circular(10)
                        : Radius.zero,
                  ),
                  color: Colors.blueGrey.shade800,
                ),
                child: const Text(
                  "hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              if (type == 'sent')
                ClipPath(
                  clipper: CustomBottomRightClipPath(),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 12,
                    width: 12,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomBottomLeftClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    // var firstControlPoint = Offset(size.width / 4, size.height);
    // var firstPoint = Offset(0, size.height);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstPoint.dx, firstPoint.dy);

    // var secondControlPoint = Offset(size.width / 4, size.height - 8);
    // var secondPoint = Offset(size.width, size.height - 8);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondPoint.dx, secondPoint.dy);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomBottomRightClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
