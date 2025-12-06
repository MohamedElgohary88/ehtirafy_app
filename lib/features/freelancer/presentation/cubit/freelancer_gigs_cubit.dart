import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/freelancer_gigs_repository.dart';
import 'freelancer_gigs_state.dart';

class FreelancerGigsCubit extends Cubit<FreelancerGigsState> {
  final FreelancerGigsRepository repository;

  FreelancerGigsCubit({required this.repository})
    : super(FreelancerGigsInitial());

  Future<void> loadGigs() async {
    emit(FreelancerGigsLoading());

    final result = await repository.getGigs();

    result.fold(
      (failure) => emit(FreelancerGigsError(failure.message)),
      (gigs) => emit(
        FreelancerGigsLoaded(
          gigs: gigs,
          categories: repository.getCategories(),
        ),
      ),
    );
  }

  Future<void> addGig({
    required String title,
    required String description,
    required double price,
    required String category,
    String? coverImage,
  }) async {
    emit(FreelancerGigAdding());

    final result = await repository.addGig(
      title: title,
      description: description,
      price: price,
      category: category,
      coverImage: coverImage,
    );

    result.fold(
      (failure) => emit(FreelancerGigAddError(failure.message)),
      (gig) => emit(FreelancerGigAdded(gig)),
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
