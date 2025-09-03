import 'package:equatable/equatable.dart';

class SaveInterestRequest extends Equatable {
  final List<int> interests;

  const SaveInterestRequest({required this.interests});

  Map<String, dynamic> toJson() => {
        'interests': interests,
      };

  @override
  List<Object?> get props => [interests];
}
