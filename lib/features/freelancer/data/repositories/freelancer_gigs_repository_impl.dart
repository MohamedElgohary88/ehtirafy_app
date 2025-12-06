import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/repositories/freelancer_gigs_repository.dart';
import '../models/gig_model.dart';

class FreelancerGigsRepositoryImpl implements FreelancerGigsRepository {
  // Local cache for mock data operations
  final List<Map<String, dynamic>> _gigsCache = List.from(
    AppMockData.mockFreelancerGigs,
  );

  @override
  Future<Either<Failure, List<GigEntity>>> getGigs() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final gigs = _gigsCache.map((json) => GigModel.fromJson(json)).toList();
      return Right(gigs);
    } catch (e) {
      return const Left(ServerFailure('فشل في جلب الخدمات'));
    }
  }

  @override
  Future<Either<Failure, GigEntity>> addGig({
    required String title,
    required String description,
    required double price,
    required String category,
    String? coverImage,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final newGig = {
        'id': 'gig-${DateTime.now().millisecondsSinceEpoch}',
        'title': title,
        'description': description,
        'price': price,
        'category': category,
        'status': 'pending', // New gigs start as pending for review
        'coverImage': coverImage ?? 'https://placehold.co/300x200.png',
        'createdAt': DateTime.now().toIso8601String(),
      };

      _gigsCache.insert(0, newGig);
      return Right(GigModel.fromJson(newGig));
    } catch (e) {
      return const Left(ServerFailure('فشل في إضافة الخدمة'));
    }
  }

  @override
  Future<Either<Failure, GigEntity>> updateGig(GigEntity gig) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final index = _gigsCache.indexWhere((g) => g['id'] == gig.id);
      if (index == -1) {
        return const Left(ServerFailure('الخدمة غير موجودة'));
      }

      final updatedJson = (gig as GigModel).toJson();
      _gigsCache[index] = updatedJson;
      return Right(gig);
    } catch (e) {
      return const Left(ServerFailure('فشل في تحديث الخدمة'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGig(String gigId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      _gigsCache.removeWhere((g) => g['id'] == gigId);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('فشل في حذف الخدمة'));
    }
  }

  @override
  List<String> getCategories() {
    return AppMockData.gigCategories;
  }
}
