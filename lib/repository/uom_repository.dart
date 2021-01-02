import 'package:http/http.dart' as http;
import 'package:touchwoodapp/screens/main.dart';
import 'dart:convert';
import 'package:touchwoodapp/models/Uom.dart';

Future<Stream<Uom>> getUoms(
    {String pagesize = '10',
    String pagenum = '1',
    String text = '',
    String tablename = '',
    String all = '0'}) async {
  String url;
  if (text == '' || text == null) {
    url = MyHome.BASE_URL +
        '/touch?&pagenumber=' +
        pagenum +
        '&pagesize=' +
        pagesize +
        '&Mode=Uom&spname=GetAndSubmitUomTable&intflag=4&strTableName=' +
        tablename +
        '' +
        '&intOrganizationUomID=1';
  } else {
    url = MyHome.BASE_URL +
        '/Uom?&intflag=4&strTableName=groupUom&pagesize=' +
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
      .map((data) => Uom.fromJSON(data));
}

Future<Stream<Uom>> getUom(String id) async {
  final String url = MyHome.BASE_URL +
      '/touch?&pagenumber=1&pagesize=20&Mode=Uom&spname=GetAndSubmitUomMaster&intflag=4&' +
      '&intOrgID=1&intUserID=1&intuommasterid=' +
      id;
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Uom.fromJSON(data))
      .where((e) => e.columnMasterid == id);
}

Future<Stream<String>> insertUom(uomid, noofdecimal, name, del) async {
  String intflag = "";
  if (del == "1") {
    intflag = "3";
  } else {
    if (uomid != '0') {
      intflag = '2';
    } else {
      intflag = '1';
    }
  }
  final String url = MyHome.BASE_URL +
      '/touch?&pagenumber=1&pagesize=20&Mode=Uom&spname=GetAndSubmitUomMaster&intflag=' +
      intflag +
      '&strUom=' +
      name +
      '' +
      '&intOrgID=1&intUserID=1&intNoofDecimal=' +
      noofdecimal +
      '&intuommasterid=' +
      uomid +
      '';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.asBroadcastStream().transform(utf8.decoder);
}
