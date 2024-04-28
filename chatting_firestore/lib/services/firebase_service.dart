import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/chat.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> getFixersList() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('users').where('role', isEqualTo: 'fixer').get();
      final List<User> fixers = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return User(
          uid: doc.id,
          email: data['email'],
        );
      }).toList();
      return fixers;
    } catch (e) {
      throw Exception('Failed to fetch fixers: $e');
    }
  }

  Future<void> createChatDocument(Chat chat) async {
    try {
      final DocumentReference chatRef = _firestore.collection('chats').doc();
      final Map<String, dynamic> chatData = {
        'participants': chat.participants,
        // Add other chat details here
      };
      await chatRef.set(chatData);
    } catch (e) {
      throw Exception('Failed to create chat document: $e');
    }
  }

  Future<void> sendMessage(String chatId, Message message) async {
    try {
      final DocumentReference chatRef = _firestore.collection('chats').doc(chatId);
      final Map<String, dynamic> messageData = {
        'sender': message.sender,
        'content': message.content,
      };
      await chatRef.collection('messages').add(messageData);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Stream<List<Message>> getChatMessages(String chatId) {
    try {
      final CollectionReference messagesRef =
          _firestore.collection('chats').doc(chatId).collection('messages');
      return messagesRef.snapshots().map((snapshot) {
        final List<Message> messages = snapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Message(
            messageId: doc.id,
            sender: data['sender'],
            content: data['content'],
          );
        }).toList();
        return messages;
      });
    } catch (e) {
      throw Exception('Failed to fetch chat messages: $e');
    }
  }
}