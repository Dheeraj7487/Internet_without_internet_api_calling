import 'package:api_internet_without_internet/Api/getPosts.dart';
import 'package:api_internet_without_internet/Helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/internet_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showData = [];
  var userIDPass = TextEditingController();
  var titlePass = TextEditingController();
  var bodyPass = TextEditingController();
  void show()  async{
    final fetchData  = await DatabaseHelper.db.fetchPostsData();
    setState(() {
      showData = fetchData;
    });
  }

  @override
  void initState() {
    super.initState();
    show();
    Provider.of<InternetProvider>(context, listen: false).checkInternet().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api Sqlite Data'),
        ),
        body: Consumer<InternetProvider>(builder: (context,snapshot,_){
          return Provider.of<InternetProvider>(context,listen: true).isInternet?
          Consumer<ApiManager>(builder: (context, snapshot, _) {
            return FutureBuilder(
                future: Provider.of<ApiManager>(context,listen: false).getPosts(),
                builder: (context, fututeSnapshot) {
                  if (fututeSnapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.postslist.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: ListTile(
                              leading: Text('${snapshot.postslist[index].id}'),
                              trailing: Text('${snapshot.postslist[index].userId}'),
                              title: Text('${snapshot.postslist[index].title}'),
                              subtitle: Text('${snapshot.postslist[index].body}'),
                            ),
                          );
                        });
                  }
                  else {
                    return CircularProgressIndicator();
                  }
                }
            );
          })  :

          ListView.builder(
            itemCount: showData.length,
            scrollDirection : Axis.vertical,
            itemBuilder: (BuildContext context,index) {
              return Card(
                color: Colors.black12,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text('${showData[index]["id"]}'),
                      title: Text('${showData[index]["title"]}'),
                      subtitle: Text('${showData[index]["body"]}'),
                      trailing: Text('${showData[index]["userId"]}'),

                    ),
                    ListTile(
                      leading: IconButton(
                          onPressed: (){
                            var id = showData[index]["id"];
                            var userID = showData[index]["userId"];
                            var userTitle = showData[index]["title"];
                            var userBody = showData[index]["body"];
                            print("ID= $id userID = $userID Title = $userTitle Body= $userBody");
                            updateform(id,userID,userTitle,userBody);
                          },
                          icon : Icon(Icons.edit,color: Colors.black54,)),
                      trailing: Container(width: 20, margin: EdgeInsets.only(left: 40),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                var proID = showData[index]["id"];
                                _delete(proID); },
                              icon : Icon(Icons.delete,color: Colors.black54,)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },)
    );
  }

  updateform(id,userIDPass1,titlePass1,bodyPass1){
    print("id = $id");
    // userIDPass=userIDPass1;
    print("title $titlePass");
    print("body $bodyPass");
    userIDPass.text = userIDPass1.toString();
    titlePass.text = titlePass1.toString();
    bodyPass.text = bodyPass1.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Update API Data"),
          actions: <Widget>[
            TextFormField(
              maxLength: 2,
              controller: userIDPass,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: titlePass,
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              controller: bodyPass,
              keyboardType: TextInputType.text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: new RaisedButton(
                    child: new Text("OK"),
                    onPressed: () {
                      _update(id);
                      show();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void _update(id) async {
    int productId = id;
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : productId,
      DatabaseHelper.columnUserId : userIDPass.text,
      DatabaseHelper.columnTitle : titlePass.text,
      DatabaseHelper.columnBody  : bodyPass.text,
    };
    print("dsd $productId");
    final rowsAffected = await DatabaseHelper.db.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete(int id) async{
    final result = await DatabaseHelper.db.deleteData(id);
    print('deleted $result row(s): row $id');
    show();
  }


}




