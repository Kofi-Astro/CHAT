import 'package:socket_io_client/socket_io_client.dart' as IO;

import './my_urls.dart';

class SocketController {
  static IO.Socket socket = IO.io(MyUrls.serverUrl, <String, dynamic>{
    'transports': ['websocket'],
  });
}
