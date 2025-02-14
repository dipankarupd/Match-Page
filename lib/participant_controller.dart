import 'package:get/get.dart';
import 'package:match/models/user.dart';

class ParticipantController {
  var participatedUsers = <User>[].obs;

  void addParticipant(User user) {
    if (!participatedUsers.any((u) => u.userId == user.userId)) {
      participatedUsers.add(user);
    }
  }

  void removeParticipant(User user) {
    participatedUsers.removeWhere((u) => u.userId == user.userId);
  }

  bool isAdded(User user) {
    return participatedUsers.any((u) => u.userId == user.userId);
  }
}
