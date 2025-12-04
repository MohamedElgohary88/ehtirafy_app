import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations();
  Future<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(MessageModel message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<List<ConversationModel>> getConversations() async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      ConversationModel(
        id: '1',
        otherUserName: 'أحمد المصور',
        otherUserImage: 'https://placehold.co/40x40.png',
        lastMessage: 'شكراً لك، سأكون جاهزاً',
        unreadCount: 2,
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ConversationModel(
        id: '2',
        otherUserName: 'سارة التصوير',
        otherUserImage: 'https://placehold.co/40x40.png',
        lastMessage: 'تم استلام طلبك',
        unreadCount: 0,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ConversationModel(
        id: '3',
        otherUserName: 'محمد الفوتوغرافي',
        otherUserImage: 'https://placehold.co/40x40.png',
        lastMessage: 'الصور جاهزة',
        unreadCount: 1,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  @override
  Future<List<MessageModel>> getMessages(String chatId) async {
    // Mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      MessageModel(
        id: '1',
        senderId: 'other',
        receiverId: 'me',
        content: 'السلام عليكم، شكراً لتواصلك معي',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
      MessageModel(
        id: '2',
        senderId: 'me',
        receiverId: 'other',
        content: 'وعليكم السلام، أريد الاستفسار عن باقة الزفاف',
        timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
        isRead: true,
      ),
      MessageModel(
        id: '3',
        senderId: 'other',
        receiverId: 'me',
        content: 'بكل سرور، الباقة تشمل تصوير 8 ساعات و300 صورة معدلة',
        timestamp: DateTime.now().subtract(const Duration(minutes: 27)),
        isRead: true,
      ),
      MessageModel(
        id: '4',
        senderId: 'me',
        receiverId: 'other',
        content: 'ممتاز، ما هي مدة التسليم؟',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        isRead: true,
      ),
      MessageModel(
        id: '5',
        senderId: 'other',
        receiverId: 'me',
        content: 'خلال 21 يوم من تاريخ الحفل',
        timestamp: DateTime.now().subtract(const Duration(minutes: 24)),
        isRead: true,
      ),
    ].reversed.toList();
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    print('Message sent: ${message.content}');
  }
}
