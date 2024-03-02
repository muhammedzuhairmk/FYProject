// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_declarations

final url = 'http://192.168.159.240:8000/';
final ImageUrl = 'http://192.168.159.240:8000';

final registration = url + "api/v1/user/signup";
final login = url + 'api/v1/user/signin';
final profile = url + 'api/v1/user/me';

// final presenteventList = url + 'api/v1/user/me';
final eventList = url + 'api/v1/event/create';
final presenteventList = url + 'api/v1/event/present';
final commingeventList = url + 'api/v1/event/upcomming';
final getEventList = url + 'api/v1/event/:id';
