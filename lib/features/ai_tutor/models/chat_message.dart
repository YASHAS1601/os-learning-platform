import 'tutor_context_model.dart';
import 'tutor_mode.dart';

enum MessageSender { user, riyah }

class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final TutorMode mode;
  final TutorContextModel? context;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.mode = TutorMode.askTutor,
    this.context,
  });

  bool get isUser => sender == MessageSender.user;
}
