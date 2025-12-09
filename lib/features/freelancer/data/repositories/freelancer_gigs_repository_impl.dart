import 'package:dartz/dartz.dart';
import 'package:ehtirafy_app/core/error/failures.dart';
import 'package:ehtirafy_app/core/error/exceptions.dart';
import 'package:ehtirafy_app/core/constants/app_mock_data.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/repositories/freelancer_gigs_repository.dart';
import '../datasources/freelancer_gigs_remote_data_source.dart';
import '../models/gig_model.dart';
import 'package:dio/dio.dart';

class FreelancerGigsRepositoryImpl implements FreelancerGigsRepository {
  final FreelancerGigsRemoteDataSource remoteDataSource;

  FreelancerGigsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<GigEntity>>> getGigs() async {
    try {
      final gigs = await remoteDataSource.getGigs();
      return Right(gigs);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
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
    List<String> availability = const [],
    List<String> images = const [],
  }) async {
    try {
      final data = {
        'ar_title': title, // Map to both for now
        'en_title': title,
        'ar_description': description,
        'en_description': description,
        'category_id': category, // Assuming category is ID
        'price': price,
        // 'images[]': ... multipart files need to be processed here if they are paths
        // 'days_availability[]': availability
      };

      // Handle images as MultipartFile if they are local paths
      if (images.isNotEmpty) {
        // This requires asynchronous file reading.
        // Since we can't easily do it inside the map literal, we build data list for FormData or map.
        // But RemoteDataSource takes Map<String, dynamic>.
        // If we pass strings, RemoteDataSource has to convert?
        // Let's assume images are local paths.

        // For simplistic implementation, we just pass the map and let DataSource handle (or we handle it here).
        // RemoteDataSource `FormData.fromMap` handles List<MultipartFile>.
        // We need to convert List<String> paths to List<MultipartFile>.

        List<MultipartFile> imageFiles = [];
        for (var path in images) {
          imageFiles.add(await MultipartFile.fromFile(path));
        }
        data['images'] = imageFiles;
      }

      if (availability.isNotEmpty) {
        data['days_availability'] = availability;
      }

      final gig = await remoteDataSource.addGig(data);
      return Right(gig);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('فشل في إضافة الخدمة'));
    }
  }

  @override
  Future<Either<Failure, GigEntity>> updateGig({
    required String id,
    required String title,
    required String description,
    required double price,
    required String category,
    String? coverImage,
    List<String> availability = const [],
    List<String> images = const [],
  }) async {
    try {
      final data = {
        'ar_title': title,
        'en_title': title,
        'ar_description': description,
        'en_description': description,
        'category_id': category,
        'price': price,
        // 'status': _gigStatusToString(gig.status), // We might not want to reset status on update unless specified
      };

      // Handle images if needed, but for now assuming URLs or handling differently
      // Since RemoteDataSource updateGig calls Dio.put/post, we might need multipart if images are files
      // But update logic here mimics add logic somewhat if we have new files

      final updatedGig = await remoteDataSource.updateGig(id, data);
      return Right(updatedGig);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('فشل في تحديث الخدمة'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGig(String gigId) async {
    try {
      await remoteDataSource.deleteGig(gigId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('فشل في حذف الخدمة'));
    }
  }

  @override
  List<String> getCategories() {
    return AppMockData.gigCategories;
  }
}
