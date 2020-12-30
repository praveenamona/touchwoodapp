import 'package:http/http.dart' as http;
import 'package:touchwoodapp/screens/main.dart';
import 'dart:convert';
import '../models/customer.dart';

Future<Stream<Customer>> getCustomers() async {
  final String url = MyHome.BASE_URL + '/partymaster?&intflag=4';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Customer.fromJSON(data));
}

Future<Stream<Customer>> getCustomer(String id) async {
  final String url = MyHome.BASE_URL + '/partymaster?&intflag=4';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Customer.fromJSON(data))
      .where((e) => e.custId == id);
}

Future<Stream<String>> insertCustomer(
    custId,
    custName,
    mobile,
    add1,
    add2,
    add3,
    add4,
    gstin,
    email,
    del,
    contact,
    taxcode,
    remarks,
    bankname,
    bankaddress,
    bankbranch,
    country,
    swiftcode,
    typeid) async {
  String intflag = "";
  if (del == "1") {
    intflag = "3";
  } else {
    if (custId != "0") {
      intflag = '2';
    } else {
      intflag = '1';
    }
  }
  final String url = MyHome.BASE_URL +
      '/touch?&pagenumber=1&pagesize=20&Mode=partymaster&spname=GetAndSubmitPartymaster' +
      '&intflag=' +
      intflag +
      '&intPartyMasterID=' +
      custId +
      '&strPartyname=' +
      custName +
      '&strAdd1=' +
      add1 +
      '&strAdd2=' +
      add2 +
      '&' +
      'strAdd3=' +
      add3 +
      '&strAdd4=' +
      add4 +
      '&strContactperson=' +
      contact +
      '&strMobileno=' +
      mobile +
      '&strEmailID=' +
      email +
      '&strTaxcode=' +
      taxcode +
      '&strRemarks=' +
      remarks +
      '&strBankname=' +
      bankname +
      '' +
      '&strBankaddress=' +
      bankaddress +
      '&strBankBranch=' +
      bankbranch +
      '&strCountry=' +
      country +
      '&strSwiftcode=' +
      swiftcode +
      '' +
      '&intOrgID=1&intPartytypeID=' +
      typeid +
      '&intUserID=1';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.asBroadcastStream().transform(utf8.decoder);
}
