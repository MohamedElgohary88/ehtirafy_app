import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/get_conversations_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetConversationsUseCase getConversationsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatCubit({
    required this.getConversationsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatInitial());

  Future<void> loadConversations() async {
    emit(ChatLoading());
    final result = await getConversationsUseCase();
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (conversations) => emit(ConversationsLoaded(conversations)),
    );
  }

  Future<void> loadMessages(String chatId) async {
    emit(ChatLoading());
    final result = await getMessagesUseCase(chatId);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  Future<void> sendMessage(MessageEntity message) async {
    // Optimistic update or just send and reload
    // For now, let's just send and reload messages
    final result = await sendMessageUseCase(message);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (_) => loadMessages(
        message.receiverId == 'me' ? message.senderId : message.receiverId,
      ), // Reload messages
    );
  }
}
