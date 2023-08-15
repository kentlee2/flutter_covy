import 'package:flutter/material.dart';
import 'package:flutter_covy/api.dart';
import 'package:flutter_covy/model/public_account.dart';
import 'package:flutter_covy/net/request_client.dart';

class PublicAccountPage extends StatefulWidget {
  const PublicAccountPage({super.key});

  @override
  State<PublicAccountPage> createState() => _PublicAccountPageState();
}

class _PublicAccountPageState extends State<PublicAccountPage> {
  List<Datum> mDatas=[];
  @override
  void initState() {
    super.initState();
     requestTabs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("公众号"),
        ),
       body: Row(
         children: [
           SizedBox(
             width: 100,
             child: ListView.builder(
               itemCount: mDatas.length,
                 itemBuilder: (c,i){
               return Text(mDatas[i].name);
             }),
           )
         ],
       ),
    );
  }

  void requestTabs()  async{
    var resp = await requestClient.get<PublicAccount>(Api.publicAccount);
    setState(() {
      mDatas =resp!.data;
    });
  }
}
