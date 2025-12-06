import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/freelancer_dashboard_repository.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/entities/portfolio_item_entity.dart';
import '../../domain/entities/freelancer_order_entity.dart';
import '../../data/models/freelancer_stats_model.dart';
import 'freelancer_dashboard_state.dart';

class FreelancerDashboardCubit extends Cubit<FreelancerDashboardState> {
  final FreelancerDashboardRepository repository;

  FreelancerDashboardCubit({required this.repository})
    : super(FreelancerDashboardInitial());

  Future<void> loadDashboard() async {
    emit(FreelancerDashboardLoading());

    // Fetch data (doing it separately for proper typing)
    final statsResult = await repository.getStats();
    final portfolioResult = await repository.getPortfolioPreview();
    final gigsResult = await repository.getGigsPreview();
    final ordersResult = await repository.getRecentOrders();

    // Check for any failures
    if (statsResult.isLeft()) {
      emit(const FreelancerDashboardError('فشل في جلب البيانات'));
      return;
    }

    emit(
      FreelancerDashboardLoaded(
        stats: statsResult.getOrElse(
          () => const FreelancerStatsModel(
            totalEarnings: 0,
            activeOrders: 0,
            profileViews: 0,
            rating: 0,
            isOnline: false,
          ),
        ),
        portfolioItems: portfolioResult.getOrElse(
          () => <PortfolioItemEntity>[],
        ),
        gigs: gigsResult.getOrElse(() => <GigEntity>[]),
        recentOrders: ordersResult.getOrElse(() => <FreelancerOrderEntity>[]),
      ),
    );
  }

  Future<void> toggleOnlineStatus(bool isOnline) async {
    if (state is FreelancerDashboardLoaded) {
      final currentState = state as FreelancerDashboardLoaded;

      final result = await repository.toggleOnlineStatus(isOnline);

      result.fold(
        (failure) {
          // Revert optimistic update on failure
        },
        (newStatus) {
          final updatedStats = FreelancerStatsModel(
            totalEarnings: currentState.stats.totalEarnings,
            activeOrders: currentState.stats.activeOrders,
            profileViews: currentState.stats.profileViews,
            rating: currentState.stats.rating,
            isOnline: newStatus,
          );
          emit(currentState.copyWith(stats: updatedStats));
        },
      );
    }
  }
}
