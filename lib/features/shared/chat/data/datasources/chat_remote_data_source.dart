import 'package:ehtirafy_app/core/network/dio_client.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/features/client/contract/data/models/contract_model.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations();
  Future<List<MessageModel>> getMessages(String contractId);
  Future<void> sendMessage(MessageModel message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final DioClient dioClient;

  // Cache contracts for message retrieval
  List<ContractModel> _cachedContracts = [];

  ChatRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      // Fetch contracts from API
      final response = await dioClient.get(
        '/api/v1/front/contracts-relative',
        queryParameters: {'user_type': 'customer'},
      );

      final data = response.data;
      if (data['status'] == 200) {
        final List list = data['data'] ?? [];
        _cachedContracts = list.map((e) => ContractModel.fromJson(e)).toList();

        // Filter contracts where chat is allowed (only accepted contracts)
        final chatAllowedContracts = _cachedContracts
            .where((contract) => contract.isChatAllowed)
            .toList();

        // Map contracts to conversations
        return chatAllowedContracts.map((contract) {
          // Get last message from chat messages
          String lastMessage = '';
          DateTime lastMessageTime = contract.updatedAt;

          if (contract.chatMessages != null &&
              contract.chatMessages!.isNotEmpty) {
            final lastMsg = contract.chatMessages!.last;
            lastMessage = lastMsg['note'] ?? '';
            try {
              lastMessageTime =
                  DateTime.tryParse(lastMsg['date'] ?? '') ??
                  contract.updatedAt;
            } catch (_) {}
          }

          return ConversationModel(
            id: contract.id.toString(),
            otherUserName: contract.photographerName ?? 'مصور',
            otherUserImage: contract.photographerImage ?? '',
            lastMessage: lastMessage.isEmpty ? 'ابدأ المحادثة...' : lastMessage,
            unreadCount: 0, // TODO: Track unread count
            lastMessageTime: lastMessageTime,
          );
        }).toList();
      } else {
        throw ServerException(
          data['message'] ?? 'Failed to fetch conversations',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String contractId) async {
    try {
      // Find contract in cache or fetch again
      ContractModel? contract;
      try {
        contract = _cachedContracts.firstWhere(
          (c) => c.id.toString() == contractId,
        );
      } catch (_) {
        // Contract not in cache, fetch fresh data
        await getConversations();
        try {
          contract = _cachedContracts.firstWhere(
            (c) => c.id.toString() == contractId,
          );
        } catch (_) {
          return [];
        }
      }

      if (contract.chatMessages == null || contract.chatMessages!.isEmpty) {
        return [];
      }

      // Get current user info to determine sender/receiver
      final currentUserId = contract.clientId;
      final photographerId = contract.photographerId;
      final messages = contract.chatMessages!;

      // Map chat messages to MessageModel
      return messages.asMap().entries.map((entry) {
        final index = entry.key;
        final msg = entry.value;

        final userType = msg['user_type'] ?? '';
        final isFromMe = userType == 'customer';

        DateTime timestamp;
        try {
          timestamp = DateTime.tryParse(msg['date'] ?? '') ?? DateTime.now();
        } catch (_) {
          timestamp = DateTime.now();
        }

        return MessageModel(
          id: '${contractId}_$index',
          senderId: isFromMe ? currentUserId : photographerId,
          receiverId: isFromMe ? photographerId : currentUserId,
          content: msg['note'] ?? '',
          timestamp: timestamp,
          isRead: true,
        );
      }).toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      // Send message via contract update API with note
      // The message.receiverId contains the contractId for our implementation
      // We need to extract contractId from the message context

      // For now, we'll use the contract update endpoint
      // The actual implementation would depend on the API structure
      final response = await dioClient.post(
        '/api/v1/front/contracts/${message.receiverId}',
        data: {
          '_method': 'PUT',
          'note_type': 'customer',
          'note_text': message.content,
        },
      );

      final data = response.data;
      if (data['status'] != 200) {
        throw ServerException(data['message'] ?? 'Failed to send message');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
