import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
//import 'package:front_end/core/constant/colors.dart';
//import 'package:front_end/presentation/home_page/widgets/event_container.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(   
          
             ),


        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),


        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          child: const Text('item 1'),
        ),


        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),


        Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          
          child: ListView(
            children: [
              Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal:15, vertical:10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: backGroundColor,
              ),
            ],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

              Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            height:150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 32,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    color: Colors.black26,
                    width: 100,
                    child: Text('${index}'),
            
                  );
                },
              ), 
              ),

              Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: backGroundColor,
              ),
            ],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

                Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 32,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    color: Colors.black26,
                    width: 100,
                    child: Text('${index}'),
            
                  );
                },
              ), 
              ),
            ],
          )
        ),
      ],
    );
  }
}
