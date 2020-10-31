class TakenTask{

  int taken;
  int unfinished;

  TakenTask({this.taken, this.unfinished});

  factory TakenTask.fromJson(Map<String, dynamic> json){

    return TakenTask(
      taken: json['taken_task'] as int,
      unfinished: json['unfinish_task'] as int,
    );
  }
}