import 'package:breach/data/models/categories_list_reponse.dart';
import 'package:equatable/equatable.dart';

class PersonaliseState extends Equatable {
  final bool isLoading;

  const PersonaliseState({required this.isLoading});

  PersonaliseState copyWith({
    bool? isLoading,
    Set<int>? selectedIds,
    Set<Category>? selectedInterests,
  }) {
    return PersonaliseState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}
