import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/freelancer_portfolio_repository.dart';
import 'freelancer_portfolio_state.dart';

class FreelancerPortfolioCubit extends Cubit<FreelancerPortfolioState> {
  final FreelancerPortfolioRepository repository;

  FreelancerPortfolioCubit({required this.repository})
    : super(FreelancerPortfolioInitial());

  Future<void> loadPortfolio() async {
    emit(FreelancerPortfolioLoading());

    final result = await repository.getPortfolioItems();

    result.fold(
      (failure) => emit(FreelancerPortfolioError(failure.message)),
      (items) => emit(FreelancerPortfolioLoaded(items: items)),
    );
  }

  Future<void> addPortfolioItem({
    required String title,
    required String description,
    required String cameraType,
    required String imageUrl,
    required String category,
  }) async {
    emit(FreelancerPortfolioItemAdding());

    final result = await repository.addPortfolioItem(
      title: title,
      description: description,
      cameraType: cameraType,
      imageUrl: imageUrl,
      category: category,
    );

    result.fold(
      (failure) => emit(FreelancerPortfolioError(failure.message)),
      (item) => emit(FreelancerPortfolioItemAdded(item)),
    );
  }

  Future<void> deletePortfolioItem(String itemId) async {
    if (state is FreelancerPortfolioLoaded) {
      final currentState = state as FreelancerPortfolioLoaded;

      final result = await repository.deletePortfolioItem(itemId);

      result.fold(
        (failure) => emit(FreelancerPortfolioError(failure.message)),
        (_) {
          final updatedItems = currentState.items
              .where((item) => item.id != itemId)
              .toList();
          emit(currentState.copyWith(items: updatedItems));
        },
      );
    }
  }
}
