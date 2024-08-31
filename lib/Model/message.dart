class Message {
  int? id;
  String chatmsg;
  bool ai;

  Message({
    this.id,
    required this.chatmsg,
    required this.ai,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatmsg': chatmsg,
      'ai': ai ? 1 : 0,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      chatmsg: map['chatmsg'] ?? '',
      ai: map['ai'] == 1,
    );
  }
}
