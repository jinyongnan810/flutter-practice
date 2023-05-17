import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketDemo extends StatefulWidget implements DemoWidget {
  const WebSocketDemo({Key? key}) : super(key: key);
  static const String _title = 'WebSocket Demo';
  static const String _description =
      'https://docs.flutter.dev/cookbook/networking/web-sockets';

  @override
  State<WebSocketDemo> createState() => _WebSocketDemoState();
  @override
  String get title => WebSocketDemo._title;

  @override
  String get description => WebSocketDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.internetExplorer);
}

class _WebSocketDemoState extends State<WebSocketDemo> {
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
            onSubmitted: (value) {
              channel.sink.add(value);
            },
          ),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          )
        ],
      ),
    );
  }
}
