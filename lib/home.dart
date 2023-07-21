import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class employee extends StatefulWidget {
  const employee({super.key});

  @override
  State<employee> createState() => _employeeState();
}

class _employeeState extends State<employee> {
  var flag=0;
  Future<dynamic> getdata() async {
    var response=await get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      flag=1;
      return jsonDecode(response.body);
    }
    else{
      flag=0;
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff19AABB),
              title: Text('Employee List',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      print(snapshot.error);
                    }
                    if(!snapshot.hasData || snapshot.data.length==0){
                      return   Center(child: Text('No data'),);
                    }


                    else if(flag==1 )
                      return ListView.builder(

                          itemCount:snapshot.data.length,
                          itemBuilder: (context ,index){
                            return  Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.red,
                                  backgroundImage: NetworkImage('${snapshot.data[index]['profile_image']}'),
                                ),
                                title: Text('${snapshot.data[index]['name']}',style: TextStyle(fontWeight: FontWeight.w400
                                ),),
                                subtitle:   Text('${snapshot.data[index]['email']}',style: TextStyle(color: Colors.black54),),
                              ),
                            );
                          }

                      );
                    else
                    {
                      return   Center(child: Text('No data'),);
                    }
                  }
              ),
            ),
            ),
        );
    }
}
