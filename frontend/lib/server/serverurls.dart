//SERVER URLS
const String SERVERWEBSOCKET = "ws://127.0.0.1:8000/ws/";
const String SERVER = "http://127.0.0.1:8000/";
var sendOtppath = Uri.parse("${SERVER}login/sendotp/");
var userAuthpath = Uri.parse("${SERVER}login/userauth/");
var regUserpath = Uri.parse("${SERVER}login/register/");
var searchUserpath = Uri.parse("${SERVER}user/searchuser/");
var sendFriendReqpath = Uri.parse("${SERVER}user/create_friend/");
var getAllReqpath = Uri.parse("${SERVER}user/get_all_req/");
var getFriendspath = Uri.parse("${SERVER}user/get_friends/");
var acceptFriendReqpath = Uri.parse("${SERVER}user/accept_friend/");
var createProjectPath = Uri.parse("${SERVER}project/create_project/");
var createProjectRequirementsPath =Uri.parse("${SERVER}project/create_requirement/");
var createProjectTasksPath = Uri.parse("${SERVER}project/create_task/");
var getProjectsspath = Uri.parse("${SERVER}project/get_project/");
var updatetaskPath = Uri.parse("${SERVER}project/update_tasks/");
var getMytaskPath = Uri.parse("${SERVER}project/get_user_tasks/");
var getProjectTasksPath = Uri.parse("${SERVER}project/get_project_tasks/");
var getCountPath = Uri.parse("${SERVER}project/get_count/");