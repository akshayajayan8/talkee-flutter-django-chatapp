class ProjectModel {
  final String pname, info, admin, deadline;
  String? pid;
  List<Members> members = [];
  List<Requirements> requirements = [];
  List<Tasks> tasks = [];

  ProjectModel(
      {this.pid,
      required this.pname,
      required this.info,
      required this.deadline,
      required this.admin});

  static Map<String, dynamic> toJson(ProjectModel value) => {
        "pname": value.pname,
        "info": value.info,
        "deadline": value.deadline,
        "admin": value.admin
      };
}

class Members {
  final String phone, fname, lname, email, date_joined;

  Members(
      {required this.phone,
      required this.fname,
      required this.lname,
      required this.email,
      required this.date_joined});
}

class Requirements {
  final String description, reqid;

  Requirements({required this.reqid, required this.description});
  static Map<String, dynamic> toJson(Requirements value) => {
        "proid": value.reqid,
        "description": value.description,
      };
}

class Tasks {
  final String taskname, deadline,  reqid, projectid;
  String? assignedTo;
  String? updatedDate = "nill";
  String? taskid;
  String? status = "incompleted";

  Tasks(
      
      {this.taskid,
      required this.reqid,
      required this.projectid,
      required this.taskname,
      required this.deadline,
      this.assignedTo,
      this.status,
      this.updatedDate});

  static Map<String, dynamic> toJson(Tasks value) => {
        "projectid": value.projectid,
        "reqid": value.reqid,
        'task': value.taskname,
        'deadline': value.deadline,
        'assign_to':value.assignedTo
      };

  static Tasks fromjson(Map taskjson)=>(
    Tasks(taskid:taskjson['taskid'].toString(),projectid: taskjson['projectid'].toString(),reqid: taskjson['reqid'].toString(),taskname: taskjson['task'].toString(),deadline: taskjson['deadline'].toString(),updatedDate: taskjson['updated_time'].toString(),status: taskjson['status'].toString() )
  );
}
