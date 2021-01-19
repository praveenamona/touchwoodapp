import 'package:http/http.dart' as http;
import 'package:touchwoodapp/main.dart';
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

Future<Stream<Customer>> getpartydetails(
    String filter, String partytypeid) async {
  //List<Customer> notifypartydetails = <Customer>[];

  final String url =
      'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=' +
          partytypeid +
          '&pagesize=10';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Customer.fromJSON(data));
  // final String customerurl =
  //     'http://tap.suninfotechnologies.in/api/touch?&Mode=partymaster&spname=GetAndSubmitPartymaster&intflag=4&intOrgID=1&intUserID=1&intPartytypeID=' +
  //         partytypeid +
  //         '&pagesize=10';

  // var response = await http.get(Uri.encodeFull(customerurl),
  //     headers: {"Accept": "application/json"});
  // //List<ItemMaster> customer1 = new List<ItemMaster>();

  // var convertDataToJson = json.decode(response.body);
  // final parsed = convertDataToJson.cast<Map<String, dynamic>>();

  // notifypartydetails =
  //     parsed.map<Customer>((json) => Customer.fromJSON(json)).toList();

  // if (filter != "")
  //   notifypartydetails = notifypartydetails
  //       .where((element) => element.customerName
  //           .toLowerCase()
  //           .toString()
  //           .contains(filter.toLowerCase().toString()))
  //       .toList();

  // // notifypartydata = notifypartydetails.map((e) => e.customerName).toList();
  // // if (notifypartyid == '' || notifypartyid == null || notifypartyid == '0')
  // //   selectednotifyparty = notifypartydata.first;

  // // notifypartyid = notifypartydetails
  // //         .where((element) => element.customerName == selectednotifyparty)
  // //         .map((e) => e.custId)
  // //         .isEmpty
  // //     ? "0"
  // //     : notifypartydetails
  // //         .where((element) => element.customerName == selectednotifyparty)
  // //         .map((e) => e.custId)
  // //         .first
  // //         .toString();

  // return notifypartydetails;
}

Future<List<String>> getpartydata(
    String filter, List<Customer> customerslist, String partytypeid) async {
  List<String> notifypartydata = [];

  if (filter != "")
    notifypartydata = customerslist.map((e) => e.customerName).toList();
  // if (notifypartyid == '' || notifypartyid == null || notifypartyid == '0')
  //   selectednotifyparty = notifypartydata.first;

  // notifypartyid = notifypartydetails
  //         .where((element) => element.customerName == selectednotifyparty)
  //         .map((e) => e.custId)
  //         .isEmpty
  //     ? "0"
  //     : notifypartydetails
  //         .where((element) => element.customerName == selectednotifyparty)
  //         .map((e) => e.custId)
  //         .first
  //         .toString();

  return notifypartydata;
}
