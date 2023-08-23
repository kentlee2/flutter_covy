import 'package:flutter/material.dart';

import '../api.dart';
import '../model/account_detail.dart';
import '../net/request_client.dart';

class PublicAccountListWidget extends StatefulWidget {
  const PublicAccountListWidget({super.key, required this.id});
  final int? id;
  @override
  State<PublicAccountListWidget> createState() =>
      _PublicAccountListWidgetState();
}

class _PublicAccountListWidgetState extends State<PublicAccountListWidget> {
  var page = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestTabDetail(widget.id.toString(), page),
      builder:
          (BuildContext context, AsyncSnapshot<List<DataElement>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(snapshot.data![index].title)),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: .5);
              },
            );
          } else {
            return Text("Error: ${snapshot.error}");
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<DataElement>> requestTabDetail(String id, int page) async {
    List<DataElement> datas = [];
    var resp = await requestClient
        .get<AccountDetail>("${Api.publicAccountDetail}$id/$page/json");
    if (page == 1) {
      datas = resp!.data.datas;
    } else {
      datas.addAll(resp!.data.datas);
    }
    return datas;
  }
}
