// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_declarations, non_constant_identifier_names

final url = 'http://1924:9000/';
final ImageUrl = 'http://192.1:9000';

final registration = url + "api/v1/user/signup";
final login = url + 'api/v1/user/signin';
final profile = url + 'api/v1/user/me';

// final presenteventList = url + 'api/v1/user/me';
final eventList = url + 'api/v1/event/create';
final presenteventList = url + 'api/v1/event/present';
final commingeventList = url + 'api/v1/event/upcomming';
final getEventList = url + 'api/v1/event/';
final viewevent=url+'api/v1/event/';
final createnotification =url +'api/v1/notification/create';
final getNotification=url +'api/v1/notification';
final deleteNotification=url+'api/v1/notification/delete/';
final editEvent=url+"api/v1/event/";
final seenNotf=url+"api/v1/notification/";
final aproveEvent=url+"api/v1/admin/event/";
final admineventview=url+"api/v1/admin/event/";
final rejectEvent=url+"api/v1/admin/event/delete/";
final getstudentlist=url+"api/v1/user/students";