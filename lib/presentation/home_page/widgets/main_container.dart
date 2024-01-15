import 'package:flutter/material.dart';
import 'package:front_end/presentation/home_page/widgets/sliding_image.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),


        SlidingImage(),


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
          height: 250,
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


          child: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(15),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Heading',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          ' As of my last knowledge update in January 2022, there isn  a universally recognized "World Computer Day." However, various countries and organizations may celebrate different days to acknowledge and commemorate the importance of computers and information technology.In general, the celebration of a World Computer Day could involve activities such as promoting digital literacy, organizing events to raise awareness about the significance of computers, and highlighting advancements in information technology that have contributed to societal progress.If there has been a recent global initiative or development related to World Computer Day since my last update, I recommend checking the latest sources for accurate and up-to-date information. Additionally, different countries or organizations may have their own observances or events dedicated to recognizing the role of computers in our lives.'),
                    ],
                  )),
            ],
          ),
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
            'Albums',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),


        Container(
          height: 500,
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white, // Use the correct color
                    ),
                  ],
                ),
                child: const Text(
                  'Today Event Images',
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
                      width: 200,
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
                      color: Colors.white, // Use the correct color
                    ),
                  ],
                ),
                child: const Text(
                  'Cumming Events',
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
          ),
        ),
      ],
    );
  }
}
