import 'package:web_socket_channel/web_socket_channel.dart';

class Websocket {
  WebSocketChannel? connection;
  String _address = '';
  bool isConnected = false;

  void setAddress(String address) {
    _address = address;
  }

  void connect() {
    try {
      final wsUrl = Uri.parse(_address);
      connection = WebSocketChannel.connect(wsUrl);
      isConnected = true;
      connection?.stream.listen((message) {
        print(message);
        connection?.sink.add(
            '{"fromId":0,"toId":0,"ope":"","type":"ping","body":"","isPrivate":false,"status":"","isRead":false}');
      });
    } catch (e) {
      print("fail");
    }
  }

  void disconnect() {
    try {
      connection?.sink.close();
      isConnected = false;
    } catch (e) {
      print("fail");
    }
  }
}
