class Customer {
  final String ptyname;
  final String partyid;

  Customer.fromJSON(Map<String, dynamic> jsonMap)
      : ptyname = jsonMap['Partytype'].toString(),
        partyid = jsonMap['partytype_id'].toString();
}
