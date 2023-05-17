import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TweenAnimationDemo extends StatefulWidget implements DemoWidget {
  const TweenAnimationDemo({Key? key}) : super(key: key);
  static const String _title = 'WebSocket Demo';
  static const String _description =
      'https://docs.flutter.dev/cookbook/networking/web-sockets';

  @override
  State<TweenAnimationDemo> createState() => _TweenAnimationDemoState();
  @override
  String get title => TweenAnimationDemo._title;

  @override
  String get description => TweenAnimationDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.internetExplorer);
}

class _TweenAnimationDemoState extends State<TweenAnimationDemo> {
  late final TextEditingController controller;
  late final WebSocketChannel channel;
  @override
  void initState() {
    controller = TextEditingController();
    channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (value) {},
          ),
          const Text('')
        ],
      ),
    );
  }
}
