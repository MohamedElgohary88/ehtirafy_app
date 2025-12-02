import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehtirafy_app/features/client/freelancer/domain/usecases/get_freelancer_profile_usecase.dart';
import 'package:ehtirafy_app/features/client/freelancer/presentation/cubits/freelancer_state.dart';

class FreelancerCubit extends Cubit<FreelancerState> {
  final GetFreelancerProfileUseCase getFreelancerProfileUseCase;

  FreelancerCubit({required this.getFreelancerProfileUseCase})
    : super(FreelancerInitial());

  Future<void> getFreelancerProfile(String id) async {
    emit(FreelancerLoading());
    final result = await getFreelancerProfileUseCase(id);
    result.fold(
      (failure) => emit(FreelancerError(failure.message)),
      (freelancer) => emit(FreelancerLoaded(freelancer)),
    );
  }
}
