class Master {
  final String columnMasterid;
  final String columnname;

  Master({this.columnMasterid, this.columnname});
  Master.fromJSON(Map<String, dynamic> jsonMap)
      : columnMasterid = jsonMap['MasterID'].toString(),
        columnname = jsonMap['MasterName'].toString();
}
