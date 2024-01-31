import 'package:flutter/material.dart';
import '/pages/Home/prof_projects.dart';
import 'ps.dart';
import '/pages/Home/add_project.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}):super(key:key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>  with SingleTickerProviderStateMixin{
   TabController? _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Change the length as needed
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddProject();
                  },
                );
        },
          backgroundColor: const Color.fromARGB(255, 59, 59, 59),
          child: Icon(Icons.add,color: Colors.blue[400],),
       ),
        appBar: PreferredSize(
          preferredSize:const Size.fromHeight(60.0),
          child: AppBar(
            bottom: TabBar(
                controller: _tabController,
                tabs:  [
                const Column(
                  children: [
                    Text('Professor'),
                    Icon(Icons.account_circle_rounded,size: 30,),
                  ],
                ),
                const Column(
                  children: [
                    Text('Students'),
                    Icon(Icons.school,size: 30,),
                  ],
                ),
                DatePickerDemo(),
              ]),
            backgroundColor: Colors.blue[400],
            
          shape: const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(bottom: Radius.circular(20))) ,),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [prof_projects(),student_projects()],
        )
      );
  }
}

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  DateTime selectedDate = DateTime(2025);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: ()
              {
                _selectDate(context);              
              },
              child: const Icon(Icons.filter_alt_rounded),);
  }
}

