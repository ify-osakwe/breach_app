import 'package:equatable/equatable.dart';

class UserInterestRequest extends Equatable {
  final List<int> interests;

  const UserInterestRequest({required this.interests});

  Map<String, dynamic> toJson() => {'interests': interests};

  @override
  List<Object?> get props => [interests];
}
