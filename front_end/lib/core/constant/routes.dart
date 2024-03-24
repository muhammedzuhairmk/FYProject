// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_declarations, non_constant_identifier_names

//ipaddress
final url = 'http://192.168.138.240:8000/';
final ImageUrl = 'http://192.168.138.240:8000';

//user
final registration = url + "api/v1/user/signup";
final login = url + 'api/v1/user/signin';
final profile = url + 'api/v1/user/me';
final resetpass = url + 'api/v1/user/password';
final deleteUser=url+"api/v1/user/";

//events
final eventList = url + 'api/v1/event/create';
final presenteventList = url + 'api/v1/event/present';
final commingeventList = url + 'api/v1/event/upcomming';
final getEventList = url + 'api/v1/event/';
final viewevent=url+'api/v1/event/';
final editEvent=url+"api/v1/event/";
final admineventview=url+"api/v1/admin/event/";

//approval
final aproveEvent=url+"api/v1/admin/event/";
final rejectEvent=url+"api/v1/admin/event/delete/";

//studentlist
final getstudentlist=url+"api/v1/user/students";

//notification
final seenNotf=url+"api/v1/notification/";
final getNotification=url +'api/v1/notification';
final createnotification =url +'api/v1/notification/create';
final deleteNotification=url+'api/v1/notification/delete/';