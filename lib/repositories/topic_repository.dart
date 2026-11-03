import '../models/topic_model.dart';

/// Mantém os temas durante a sessão, independentemente da tela aberta.
class TopicRepository {
  TopicRepository._();

  static final instance = TopicRepository._();

  final List<Topic> _topics = [];

  List<Topic> get topics => List.unmodifiable(_topics);

  void add(Topic topic) => _topics.add(topic);

  void update(int index, Topic topic) => _topics[index] = topic;
}
