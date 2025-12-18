import 'package:equatable/equatable.dart';

/// Enum for contract status mapping from API to UI
enum ContractStatus {
  pending,
  accepted,
  rejected,
  completed,
  cancelled;

  /// Get Arabic display name for UI badges
  String get displayName {
    switch (this) {
      case ContractStatus.pending:
        return 'قيد الانتظار';
      case ContractStatus.accepted:
        return 'مقبول';
      case ContractStatus.rejected:
        return 'مرفوض';
      case ContractStatus.completed:
        return 'مكتمل';
      case ContractStatus.cancelled:
        return 'ملغي';
    }
  }

  /// Parse from API string value
  static ContractStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'accepted':
        return ContractStatus.accepted;
      case 'rejected':
        return ContractStatus.rejected;
      case 'completed':
        return ContractStatus.completed;
      case 'cancelled':
        return ContractStatus.cancelled;
      default:
        return ContractStatus.pending;
    }
  }
}

class ContractEntity extends Equatable {
  final int id;
  final String advertisementId;

  // App-friendly naming (mapped from API's freelancer/customer)
  final String photographerId; // Maps from publisher_id (freelancer)
  final String clientId; // Maps from customer_id

  final String requestedAmount;
  final String actualAmount;

  // Status fields
  final String?
  contrPubStatus; // Photographer's status (accepted/rejected/completed)
  final String? contrCustStatus; // Client's status (cancelled/completed)

  final DateTime createdAt;
  final DateTime updatedAt;

  // Display fields for lists
  final String? serviceTitle;
  final String? photographerName;
  final String? photographerImage;
  final String? clientName;
  final String? clientImage;

  // Chat messages embedded in contract (if present)
  final List<Map<String, dynamic>>? chatMessages;

  const ContractEntity({
    required this.id,
    required this.advertisementId,
    required this.photographerId,
    required this.clientId,
    required this.requestedAmount,
    required this.actualAmount,
    this.contrPubStatus,
    this.contrCustStatus,
    required this.createdAt,
    required this.updatedAt,
    this.serviceTitle,
    this.photographerName,
    this.photographerImage,
    this.clientName,
    this.clientImage,
    this.chatMessages,
  });

  /// Get the combined status for display
  /// Priority: rejected > cancelled > completed > accepted > pending
  ContractStatus get displayStatus {
    if (contrPubStatus == 'rejected') return ContractStatus.rejected;
    if (contrCustStatus == 'cancelled') return ContractStatus.cancelled;
    if (contrPubStatus == 'completed' || contrCustStatus == 'completed') {
      return ContractStatus.completed;
    }
    if (contrPubStatus == 'accepted') return ContractStatus.accepted;
    return ContractStatus.pending;
  }

  /// Check if chat is allowed for this contract
  /// Rule: Chat is allowed only when contract is ACCEPTED (in progress)
  /// Chat is NOT allowed when: pending, rejected, cancelled, or completed
  bool get isChatAllowed {
    final status = displayStatus;
    return status == ContractStatus.accepted;
  }

  @override
  List<Object?> get props => [
    id,
    advertisementId,
    photographerId,
    clientId,
    requestedAmount,
    actualAmount,
    contrPubStatus,
    contrCustStatus,
    createdAt,
    updatedAt,
    serviceTitle,
    photographerName,
    photographerImage,
    clientName,
    clientImage,
    chatMessages,
  ];
}
