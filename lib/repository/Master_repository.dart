import 'package:http/http.dart' as http;
import 'package:touchwoodapp/screens/main.dart';
import 'dart:convert';
import 'package:touchwoodapp/models/Master.dart';

Future<Stream<Master>> getMasters(
    {String pagesize = '10',
    String pagenum = '1',
    String text = '',
    String all = '0'}) async {
  String url;
  if (text == '' || text == null) {
    url = MyHome.BASE_URL +
        '/master?&intflag=4&strTableName=groupmaster&pagesize=' +
        pagesize +
        '&pagenumber=' +
        pagenum +
        (all == '1' ? '&records=ALL' : '');
  } else {
    url = MyHome.BASE_URL +
        '/master?&intflag=4&strTableName=groupmaster&pagesize=' +
        pagesize +
        '&pagenumber=' +
        pagenum +
        '&strColumnData=' +
        text +
        (all == '1' ? '&records=ALL' : '');
  }

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Master.fromJSON(data));
}

Future<Stream<Master>> getMaster(String id) async {
  final String url = MyHome.BASE_URL +
      '/master?&intflag=4&strTableName=groupmaster&pagesize=10000';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Master.fromJSON(data))
      .where((e) => e.columnMasterid == id);
}

Future<Stream<String>> insertMaster(
    masterid, name, userid, columndata, del) async {
  String intflag = "";
  if (del == "1") {
    intflag = "3";
  } else {
    if (masterid != '0') {
      intflag = '2';
    } else {
      intflag = '1';
    }
  }
  final String url = MyHome.BASE_URL +
      '/master?&intflag=' +
      intflag +
      '&strTableName=' +
      name +
      '&' +
      'intMasterID=' +
      '' +
      masterid.toString() +
      '' +
      '&intUserID=' +
      userid +
      '&strColumnData=' +
      columndata;
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.transform(utf8.decoder);
}
