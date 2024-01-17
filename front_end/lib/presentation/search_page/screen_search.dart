import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All events'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:const  EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Search an event',
                            ),
                          ),
                        ),
                        IconButton(
                          icon:const  Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon:const  Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );

                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        print('Selected Date: $selectedDate');
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Events on ${selectedDate.toLocal()}'),
        ],
      ),
    );
  }
}
