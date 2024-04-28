class Chat {
  final List<String> participants;
  final List<Message> messages;

  Chat({required this.participants, required this.messages});
}

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}