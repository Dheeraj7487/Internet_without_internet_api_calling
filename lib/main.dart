import 'package:api_internet_without_internet/Api/getPosts.dart';
import 'package:flutter/material.dart';
import 'Home1.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';
import 'Provider/internet_provider.dart';

void main() {
  runApp((MyApp()),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiManager(),),
        ChangeNotifierProvider(create: (context) => InternetProvider(),),
      ],
      child: MaterialApp(
        home: MyData(),
      ),
    );
  }
}

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              child: Text("With Internet Plugin"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home1()));
                Provider.of<ApiManager>(context,listen: false).getPosts();
              },
              child: Text("Without Internet Plugin"),
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:api_internet_without_internet/Api/getPosts.dart';
// import 'package:api_internet_without_internet/Model/model.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'Helper/database_helper.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   List<Model>? modelData;
//
//   // List<dynamic> postsId = [];
//   // List<dynamic> postsUserId = [];
//   // List<dynamic> postsTitle = [];
//   // List<dynamic> postsBody = [];
//   var postsId, postsUserId,postsTitle,postsBody;
//   // var postsId = [];
//   // var postsUserId = [];
//   // var postsTitle = [];
//   // var postsBody = [];
//   var isLoading = false;
//   // DatabaseHelper dbHelper = DatabaseHelper.db.database as DatabaseHelper;
//
//   _insert() async {
//     Database? db = await DatabaseHelper.db.database;
//     Map<String, dynamic> row = {
//       DatabaseHelper.columnId : postsId.toString(),
//       DatabaseHelper.columnUserId : postsUserId.toString(),
//       DatabaseHelper.columnTitle  : postsTitle.toString(),
//       DatabaseHelper.columnBody : postsBody.toString(),
//     };
//     int? id = await db?.insert(DatabaseHelper.table, row);
//     print(await db?.query(DatabaseHelper.table));
//   }
//
//   var showData = [];
//   void show()  async{
//     final fetchData  = await DatabaseHelper.db.fetchPostsData();
//     setState(() {
//       showData = fetchData;
//     });
//   }
//
//   refresList(){
//     setState(() {
//       show();
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // refresList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("API Data"),
//         ),
//         body:  Center(
//             child: FutureBuilder(
//               future: ApiManager().getPosts(),
//               builder: (context, snapshot) {
//                 modelData = snapshot.data as List<Model>?;
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return ListView.builder(
//                       itemCount: showData.length,
//                       itemBuilder: (BuildContext context,index) {
//                         return Card(
//                           color: Colors.white.withOpacity(1.0),
//                           child : ListTile(
//                             leading: Text('${index + 1}'),
//                             trailing: Text('${postsId}'),
//                             title: Text('${showData[index]["title"]}'),
//                             subtitle: Text('${showData[index]["body"]}'),
//                           ),
//                         );
//                       },
//                     );
//
//                   return ListView.builder(
//                       itemCount: modelData?.length,
//                       itemBuilder: (context, index) {
//                         postsUserId = modelData![index].userId;
//                         postsTitle = modelData![index].title;
//                         postsBody = modelData![index].body;
//                         _insert();
//                         return Container(
//                           child: Text(' ${modelData![index].id} '),
//                         );
//                       });
//
//                 } else {
//                   return ListView.builder(
//                     itemCount: showData.length,
//                     itemBuilder: (BuildContext context,index) {
//                       return Card(
//                         color: Colors.white.withOpacity(1.0),
//                         child : ListTile(
//                           leading: Text('${showData[index]["id"]}'),
//                           trailing: Text('${showData[index]["userId"]}'),
//                           title: Text('${showData[index]["title"]}'),
//                           subtitle: Text('${showData[index]["body"]}'),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             )
//         )
//     );
//   }
// }
