import 'dart:convert';
import 'package:ehtirafy_app/features/client/contract/domain/entities/contract_entity.dart';

/// Helper to parse localized fields that can be either String or Map with ar/en keys
String _parseLocalizedField(dynamic field) {
  if (field == null) return '';
  if (field is String) return field;
  if (field is Map) {
    // Prefer Arabic, fallback to English
    return field['ar']?.toString() ?? field['en']?.toString() ?? '';
  }
  return field.toString();
}

/// Contract model with mapping from API naming to app naming
/// API uses: freelancer (photographer), customer (client)
/// App uses: photographer (freelancer), client (customer)
class ContractModel extends ContractEntity {
  const ContractModel({
    required super.id,
    required super.advertisementId,
    required super.photographerId,
    required super.clientId,
    required super.requestedAmount,
    required super.actualAmount,
    super.contrPubStatus,
    super.contrCustStatus,
    required super.createdAt,
    required super.updatedAt,
    super.serviceTitle,
    super.photographerName,
    super.photographerImage,
    super.clientName,
    super.clientImage,
    super.chatMessages,
  });

  /// Parse from API JSON with mapping:
  /// - publisher_id → photographerId
  /// - customer_id → clientId
  /// - publisher.name → photographerName
  /// - customer.name → clientName
  factory ContractModel.fromJson(Map<String, dynamic> json) {
    // Parse chat messages if embedded in contract
    List<Map<String, dynamic>>? parsedMessages;
    if (json['chat_messages'] != null) {
      try {
        if (json['chat_messages'] is String) {
          final decoded = jsonDecode(json['chat_messages']);
          if (decoded is List) {
            parsedMessages = decoded.cast<Map<String, dynamic>>();
          }
        } else if (json['chat_messages'] is List) {
          parsedMessages = (json['chat_messages'] as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();
        }
      } catch (_) {
        // Ignore parsing errors for chat messages
      }
    }

    return ContractModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      advertisementId: json['advertisement_id']?.toString() ?? '',
      // API mapping: publisher → photographer
      photographerId: json['publisher_id']?.toString() ?? '',
      // API mapping: customer → client
      clientId: json['customer_id']?.toString() ?? '',
      requestedAmount: json['requested_amount']?.toString() ?? '0',
      actualAmount: json['actual_amount']?.toString() ?? '0',
      contrPubStatus: json['contr_pub_status'],
      contrCustStatus: json['contr_cust_status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      // Service/Advertisement details - title can be String or Map with localized values
      serviceTitle: _parseLocalizedField(json['advertisement']?['title']),
      // Photographer (freelancer) details
      photographerName: json['publisher']?['name'] ?? '',
      photographerImage: json['publisher']?['image'] ?? '',
      // Client (customer) details
      clientName: json['customer']?['name'] ?? '',
      clientImage: json['customer']?['image'] ?? '',
      // Chat messages embedded in contract
      chatMessages: parsedMessages,
    );
  }

  /// Convert to JSON for API requests
  /// Uses API naming: publisher_id, customer_id
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advertisement_id': advertisementId,
      'publisher_id': photographerId, // App → API mapping
      'customer_id': clientId, // App → API mapping
      'requested_amount': requestedAmount,
      'actual_amount': actualAmount,
      'contr_pub_status': contrPubStatus,
      'contr_cust_status': contrCustStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create request body for initial contract creation
  static Map<String, dynamic> createRequestBody({
    required String advertisementId,
    required String photographerId,
    required String clientId,
    required String amount,
  }) {
    return {
      'advertisement_id': advertisementId,
      'publisher_id': photographerId, // API expects publisher_id
      'customer_id': clientId, // API expects customer_id
      'requested_amount': amount,
      'actual_amount': amount,
    };
  }

  /// Create request body for status update
  static Map<String, dynamic> createStatusUpdateBody({
    required bool isPhotographer,
    required String status,
    String? noteText,
  }) {
    final body = <String, dynamic>{
      '_method': 'put',
      'note_type': isPhotographer ? 'freelancer' : 'customer',
    };

    if (isPhotographer) {
      body['contr_pub_status'] = status; // accepted, rejected, completed
    } else {
      body['contr_cust_status'] = status; // cancelled, completed
    }

    if (noteText != null && noteText.isNotEmpty) {
      body['note_text'] = noteText;
    }

    return body;
  }
}
