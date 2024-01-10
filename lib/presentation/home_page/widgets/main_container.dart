import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/home_page/widgets/event_container.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          alignment: Alignment.center,
          color: BackGroundColor,
          child: AutoSlideContainer(),
        ),

        SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 32,
          itemBuilder: (context,index){
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            color: Colors.black26,
            width: 100,
            child: 
            Text('${index}'),
  
          );
        }
        ),
        ),

        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          alignment: Alignment.center,
          color: BackGroundColor,
          child:const  Text('item 1'),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          alignment: Alignment.center,
          color: BackGroundColor,
          child:const  Text('item 1'),
        ),Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          alignment: Alignment.center,
          color: BackGroundColor,
          child:const  Text('item 1'),
        )

      ],
    );
  }
}