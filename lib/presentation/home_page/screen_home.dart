import 'package:flutter/material.dart';
import 'package:front_end/presentation/widgets/app_bar_widget.dart';
import 'widgets/event_container.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: EventDayContainer(),
      ) 
    );
  }
}




