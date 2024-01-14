import 'package:flutter/material.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  int _currentStep = 0;

  List<Step> stepList() => [
        Step(
          title: const Text('Account'),
          isActive: _currentStep >= 0,
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Username',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        Step(
          title: Text('personal details'),
          isActive: _currentStep >= 1,
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Address',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Admission Year',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'RollNo',
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        Step(
          title: Text(' Password'),
          isActive: _currentStep >= 2,
          state: StepState.complete,
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Password',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Confirm Password',
                ),
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventSnap'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin:const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:const  Center(
              child: Text(
                "Account Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stepper(
                steps: stepList(),
                elevation: 0,
                onStepTapped: (int newIndex) {
                  setState(() {
                    _currentStep = newIndex;
                  });
                },
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < (stepList().length - 1)) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
              ),
            ),
          ),
          ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                },
                child: Text('Save'),
          
          ),
        ],
      ),
    );
  }
}




        // ListView(
        //   children: [
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     Container(
        //       height: 40,
        //       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         boxShadow: const [
        //           BoxShadow(
        //             color: Colors.white, // Use the correct color
        //           ),
        //         ],
        //       ),
        //       child: const Text(
        //         'Personal Details',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //     Column(
        //       children: [
        //         Container(
        //           padding:const EdgeInsets.all(15),
        //           margin: const EdgeInsets.all(20),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(20),
        //             boxShadow: const [
        //               BoxShadow(
        //                 color: Colors.white,
        //               ),
        //             ],
        //           ),

        //            child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.person_outline_outlined),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   'Username',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.alternate_email_rounded),
        //                   onPressed: () {
        //                     // Handle camera icon press

        //                   },
        //                 ),
        //               const  Text(
        //                   'Email',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //             Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.call),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   'Phone NO',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [

        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.password),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   ' Password',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.filter_list),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   'Address',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.numbers_rounded),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   'Roll No',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),

        //           Container(
        //             height: 70,
        //             width: 70,
        //             margin: EdgeInsets.all(15),
        //             decoration: BoxDecoration(color: backGroundColor,borderRadius: BorderRadius.circular(20)),
        //             child: Column(
        //               children: [
        //                 IconButton(
        //                   color: Colors.white,
        //                   hoverColor:const  Color.fromARGB(255, 78, 131, 175),
        //                   icon:const  Icon(Icons.calendar_month_rounded),
        //                   onPressed: () {
        //                     // Handle camera icon press
        //                     print('Camera icon pressed');
        //                   },
        //                 ),
        //               const  Text(
        //                   'Bacth',
        //                   style:  TextStyle(
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //       ],
        //     ),
        //         )
        //   ],
        // ),
        //   ]
        // )