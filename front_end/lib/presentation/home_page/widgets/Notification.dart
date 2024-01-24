import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ScreenNotification extends StatefulWidget {
  const ScreenNotification({super.key});

  @override
  State<ScreenNotification> createState() => _DashboardState();
}

class _DashboardState extends State<ScreenNotification> {
  final getStoage = GetStorage();
  final textLongUrl = TextEditingController();
  final getConnect = GetConnect();

  List<Map<String,dynamic>> dataList = [];

  void _urlSubmit(longurl) async{

    Map<String,dynamic> userData = getStoage.read('user');
    String userId = userData['_id'];

    final res = await getConnect.post('http://192.168.29.239:3000/urlSubmit',
        {
          'userId': userId,
          'longUrl': longurl
    });

    print(res.body['shortUrl']);

    Get.snackbar("Short URL Created", res.body['shortUrl']);
    textLongUrl.text="";
  }

  Future<void> _fetchUserUrl(userId) async {
  
    final response = await getConnect.post('http://192.168.14.131:3000/getUserURL', {
        'userId' : userId
    });

    final List<dynamic> data = response.body['success'];

    setState(() {
      dataList = List<Map<String,dynamic>>.from(data);
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> userData = getStoage.read('user');
    String userId = userData['_id'];

    _fetchUserUrl(userId);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  const Text("* URL SHORTENER *",style: TextStyle(fontSize: 30),),
                  const Text("Long URL to Short URL"),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Long URL",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                ),
                                controller: textLongUrl,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return " Please Enter long Url";
                                  }
                                  return null;
                                }
                            ),
                          ),
                          SizedBox(width: 10), // Add some spacing between TextField and Button
                          ElevatedButton(
                            onPressed: () {
                              _urlSubmit(textLongUrl.text);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  dataList.isEmpty ? CircularProgressIndicator(): Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: dataList.length,
                          itemBuilder: (context,index){
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 16),
                            child: ListTile(
                              title: Text("http://192.168.29.239/${dataList[index]['shorturl']}"),
                              subtitle: Text('${dataList[index]['longUrl']}'),
                            ),
                          );
                          }
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}