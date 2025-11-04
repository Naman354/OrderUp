import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer';


class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('https://your-api-url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      log('Socket connected');
    });

    socket.on('new_order', (data) {
      // Emit or listen for new orders
      log('New order received: $data');
    });

    socket.onDisconnect((_) => log('Socket disconnected'));
  }

  void dispose() {
    socket.disconnect();
  }
}
