import 'package:equatable/equatable.dart';
import 'package:ehtirafy_app/features/client/home/domain/entities/photographer_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PhotographerEntity> featuredPhotographers;

  const HomeLoaded({required this.featuredPhotographers});

  @override
  List<Object> get props => [featuredPhotographers];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
