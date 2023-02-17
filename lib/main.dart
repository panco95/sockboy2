import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

const appName = 'Socket测试助手';
void main(List<String> args) {
  runApp(const App());
}

String protocol = 'tcp';
String address = '';
var appContext;

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        platform: TargetPlatform.android,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.quiz_outlined),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.blueAccent,
          title: const Text('Sockboy'),
          toolbarHeight: 50,
          iconTheme: const IconThemeData(
            color: Colors.blueAccent,
            opacity: 0.5,
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          items: const <Widget>[
            Icon(Icons.connected_tv, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
        body: const Index(),
      ),
    );
  }
}

class Index extends StatelessWidget {
  const Index({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.network_cell),
                    iconColor: Colors.white,
                    label: Text('请选择网络协议'),
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color.fromARGB(255, 47, 91, 112),
                  iconEnabledColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                      value: 'tcp',
                      enabled: true,
                      child: Text('TCP'),
                    ),
                    DropdownMenuItem(
                      value: 'udp',
                      enabled: true,
                      child: Text('UDP'),
                    ),
                    DropdownMenuItem(
                      value: 'ws',
                      enabled: true,
                      child: Text('Websocket'),
                    ),
                  ],
                  onChanged: (value) {
                    protocol = value!;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    icon: Icon(Icons.connected_tv),
                    iconColor: Colors.white,
                    label: Text('请输入网络地址'),
                    labelStyle: TextStyle(color: Colors.white60),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    address = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFE8E8E8)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 14.0)),
                    minimumSize: MaterialStateProperty.all(const Size(0, 0)),
                    maximumSize:
                        MaterialStateProperty.all(const Size(375.0, 36.0)),
                  ),
                  child: const Text(
                    '连接',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF646464),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    connect();
                  },
                ),
              ]),
        ));
  }
}

void connect() {
  try {
    final wsUrl = Uri.parse(address);
    var channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
      print("success");
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
  } catch (e) {
    print(e);
    print("fail");
  }
}
