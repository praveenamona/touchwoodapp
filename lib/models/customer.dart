class Customer {
  final String custId;
  final String customerName;
  final String mobile;
  final String partytypeMasterID;
  final String email;
  final String add1;
  final String add2;
  final String add3;
  final String add4;
  final String partytype;
  final String gstin;

  Customer.fromJSON(Map<String, dynamic> jsonMap)
      : add1 = jsonMap['Add1'].toString(),
        add2 = jsonMap['Add2'].toString(),
        email = jsonMap['EmailID'].toString(),
        gstin = jsonMap['Gstin'].toString(),
        add3 = jsonMap['Add3'].toString(),
        add4 = jsonMap['Add4'].toString(),
        custId = jsonMap['PartyMasterID'].toString(),
        customerName = jsonMap['Partyname'].toString(),
        mobile = jsonMap['Mobileno'].toString(),
        partytypeMasterID = jsonMap['PartytypeMasterID'].toString(),
        partytype = jsonMap['Partytype'].toString();
}
