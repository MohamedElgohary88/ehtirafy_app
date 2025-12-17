import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/freelancer_gigs_repository.dart';
import 'freelancer_gigs_state.dart';

class FreelancerGigsCubit extends Cubit<FreelancerGigsState> {
  final FreelancerGigsRepository repository;

  FreelancerGigsCubit({required this.repository})
    : super(FreelancerGigsInitial());

  Future<void> loadGigs() async {
    emit(FreelancerGigsLoading());

    final gigsResult = await repository.getGigs();
    final categoriesResult = await repository.getCategories();

    gigsResult.fold((failure) => emit(FreelancerGigsError(failure.message)), (
      gigs,
    ) {
      categoriesResult.fold(
        (failure) => emit(FreelancerGigsLoaded(gigs: gigs, categories: [])),
        (categories) =>
            emit(FreelancerGigsLoaded(gigs: gigs, categories: categories)),
      );
    });
  }

  Future<void> addGig({
    required String title,
    required String description,
    required double price,
    required String category,
    String? coverImage,
    List<String> availability = const [],
    List<String> images = const [],
  }) async {
    emit(FreelancerGigAdding());

    final result = await repository.addGig(
      title: title,
      description: description,
      price: price,
      category: category,
      coverImage: coverImage,
      availability: availability,
      images: images,
    );

    result.fold(
      (failure) => emit(FreelancerGigAddError(failure.message)),
      (gig) => emit(FreelancerGigAdded(gig)),
    );
  }

  Future<void> updateGig({
    required String id,
    required String title,
    required String description,
    required double price,
    required String category,
    String? coverImage,
    List<String> availability = const [],
    List<String> images = const [],
  }) async {
    emit(FreelancerGigUpdating());

    final result = await repository.updateGig(
      id: id,
      title: title,
      description: description,
      price: price,
      category: category,
      coverImage: coverImage,
      availability: availability,
      images: images,
    );

    result.fold(
      (failure) => emit(FreelancerGigUpdateError(failure.message)),
      (gig) => emit(FreelancerGigUpdated(gig)),
    );
  }

  Future<void> deleteGig(String gigId) async {
    if (state is FreelancerGigsLoaded) {
      final currentState = state as FreelancerGigsLoaded;

      final result = await repository.deleteGig(gigId);

      result.fold((failure) => emit(FreelancerGigsError(failure.message)), (_) {
        final updatedGigs = currentState.gigs
            .where((gig) => gig.id != gigId)
            .toList();
        emit(currentState.copyWith(gigs: updatedGigs));
      });
    }
  }
}
