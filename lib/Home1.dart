import 'package:api_internet_without_internet/Api/getPosts.dart';
import 'package:api_internet_without_internet/Helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/internet_provider.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api Sqlite Data'),
        ),
        body: Consumer<ApiManager>(builder: (context, snapshot, _) {
            return FutureBuilder(
                future: Provider.of<ApiManager>(context,listen: false).getPosts(),
                builder: (context, fututeSnapshot) {
                  if (fututeSnapshot.hasData) {
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
                    return ListView.builder(
                        itemCount: snapshot.showData.length,
                        itemBuilder: (_, index) {
                          return Card(
                            color: Colors.grey,
                            child: ListTile(
                              leading: Text('${snapshot.showData[index]['id']}'),
                              trailing: Text('${snapshot.showData[index]['userId']}'),
                              title: Text('${snapshot.showData[index]['title']}'),
                              subtitle: Text('${snapshot.showData[index]['body']}'),
                            ),
                          );
                        });
                  }
                }
            );
          })
    );
  }
}





