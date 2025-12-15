import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/freelancer_dashboard_repository.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_statistics.dart';
import '../../domain/entities/freelancer_last_contract.dart';
import '../../domain/usecases/get_freelancer_statistics_usecase.dart';
import '../../domain/usecases/get_freelancer_last_contracts_usecase.dart';
import 'freelancer_dashboard_state.dart';

class FreelancerDashboardCubit extends Cubit<FreelancerDashboardState> {
  final FreelancerDashboardRepository repository;
  final GetFreelancerStatisticsUseCase _getFreelancerStatisticsUseCase;
  final GetFreelancerLastContractsUseCase _getFreelancerLastContractsUseCase;

  FreelancerDashboardCubit({
    required this.repository,
    required GetFreelancerStatisticsUseCase getFreelancerStatisticsUseCase,
    required GetFreelancerLastContractsUseCase
    getFreelancerLastContractsUseCase,
  }) : _getFreelancerStatisticsUseCase = getFreelancerStatisticsUseCase,
       _getFreelancerLastContractsUseCase = getFreelancerLastContractsUseCase,
       super(FreelancerDashboardInitial());

  Future<void> loadDashboard() async {
    emit(FreelancerDashboardLoading());

    // Get User ID from repository (assuming method exists or we can get it)
    final userId = await repository.getUserId();
    if (userId == null) {
      emit(const FreelancerDashboardError('User not found'));
      return;
    }

    // Fetch data including new APIs
    final statsResult = await _getFreelancerStatisticsUseCase(userId);
    final lastContractsResult = await _getFreelancerLastContractsUseCase(
      userId,
    );
    final portfolioResult = await repository.getPortfolioPreview();
    final gigsResult = await repository.getGigsPreview();
    final userName = await repository.getUserName();

    // Check for any failures
    if (statsResult.isLeft()) {
      // Handle error more gracefully or just log it and show partial data if possible
      // For now, let's fail if stats fail
      String errorMsg = 'Failed to fetch statistics';
      statsResult.fold((l) => errorMsg = l.message, (r) => null);
      emit(FreelancerDashboardError(errorMsg));
      return;
    }

    emit(
      FreelancerDashboardLoaded(
        stats: statsResult.getOrElse(
          () => const FreelancerStatistics(
            completedOrders: 0,
            averageRating: 0.0,
            totalEarnings: 0.0,
            activeGigs: 0,
          ),
        ),
        portfolioItems: portfolioResult.getOrElse(
          () => <PortfolioItemEntity>[],
        ),
        gigs: gigsResult.getOrElse(() => <GigEntity>[]),
        lastContracts: lastContractsResult.getOrElse(
          () => <FreelancerLastContract>[],
        ),
        userName: userName,
        isOnline:
            true, // Default to true or fetch from somewhere else if needed
      ),
    );
  }

  Future<void> toggleOnlineStatus(bool isOnline) async {
    if (state is FreelancerDashboardLoaded) {
      final currentState = state as FreelancerDashboardLoaded;
      final result = await repository.toggleOnlineStatus(isOnline);

      result.fold((failure) {}, (newStatus) {
        emit(currentState.copyWith(isOnline: newStatus));
      });
    }
  }
}
