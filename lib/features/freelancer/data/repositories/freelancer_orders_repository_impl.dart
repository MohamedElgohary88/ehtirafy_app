import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import '../../domain/entities/freelancer_order_entity.dart';
import '../../domain/repositories/freelancer_orders_repository.dart';
import '../models/freelancer_order_model.dart';

class FreelancerOrdersRepositoryImpl implements FreelancerOrdersRepository {
  // Local cache for mock data operations
  final List<Map<String, dynamic>> _ordersCache = List.from(
    AppMockData.mockFreelancerOrders,
  );

  @override
  Future<Either<Failure, List<FreelancerOrderEntity>>> getOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final orders = _ordersCache
          .map((json) => FreelancerOrderModel.fromJson(json))
          .toList();
      return Right(orders);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب الطلبات'));
    }
  }

  @override
  Future<Either<Failure, FreelancerOrderEntity>> acceptOrder(
    String orderId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _ordersCache.indexWhere((o) => o['id'] == orderId);
      if (index == -1) {
        return const Left(ServerFailure('الطلب غير موجود'));
      }

      // Update status to inProgress
      _ordersCache[index]['status'] = 'inProgress';
      return Right(FreelancerOrderModel.fromJson(_ordersCache[index]));
    } catch (e) {
      return const Left(ServerFailure('فشل في قبول الطلب'));
    }
  }

  @override
  Future<Either<Failure, void>> rejectOrder(String orderId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _ordersCache.indexWhere((o) => o['id'] == orderId);
      if (index == -1) {
        return const Left(ServerFailure('الطلب غير موجود'));
      }

      // Update status to cancelled
      _ordersCache[index]['status'] = 'cancelled';
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('فشل في رفض الطلب'));
    }
  }

  @override
  Future<Either<Failure, FreelancerOrderEntity>> getOrderDetails(
    String orderId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final orderJson = _ordersCache.firstWhere(
        (o) => o['id'] == orderId,
        orElse: () => throw Exception('Order not found'),
      );
      return Right(FreelancerOrderModel.fromJson(orderJson));
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب تفاصيل الطلب'));
    }
  }
}
