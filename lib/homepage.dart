import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/modelclass.dart';

class api05 extends StatefulWidget {
  const api05({Key? key}) : super(key: key);

  @override
  State<api05> createState() => _api05State();
}

class _api05State extends State<api05> {
  Future<List> getUserData() async {
    List userapidata = [];
    final responseone =
        await http.get(Uri.parse('https://reqres.in/api/users/'));

    debugPrint(
        'get api status code check ${responseone.body}\n${responseone.statusCode}');

    if (responseone.statusCode == 200) {
      print(userapidata);
      dynamic getUserData = jsonDecode(responseone.body);
      print(getUserData['data']
          .map((dynamic index) => Datum.fromJson(index))
          .toList()
          .runtimeType);
      userapidata = getUserData['data']
          .map((dynamic index) => Datum.fromJson(index))
          .toList();
      print(userapidata);
    } else {
      debugPrint('Something Wrong');
    }

    return userapidata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('FETCHED DATA')),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: getUserData(),
          builder: (context, snapshot) {
            print('yes${snapshot.data}${snapshot.connectionState}');
            if (snapshot.data == null && !snapshot.hasData) {
              return Center(
                child: Text('Loading.....'),
              );
            } else {
              return (ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10)
                      child:ListTile(
                      leading: SizedBox.square(
                        dimension: 100,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data![index].avatar),
                        ),
                      ),
                      title: Card(
                          child: SizedBox(
                              height: 35,
                              width: 5o,
                              child:
                                  Text(snapshot.data![index]!.lastName))),
                      subtitle: Card(
                          child: SizedBox(
                              height: 35,
                              width: 50,
                              child: Text(snapshot.data![index].email))),
                      trailing: Card(
                          child: SizedBox(
                              height: 35,
                              width: 50,
                              child: Text(snapshot.data![index]!.firstName))),
                    );
                  }));
            }
          },
        ),
      ),
    );
  }
}
