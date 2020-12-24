class Master {
  final String columnMasterid;
  final String columnname;
  final String tablename;

  Master({this.columnMasterid, this.columnname, this.tablename});
  Master.fromJSON(Map<String, dynamic> jsonMap)
      : columnMasterid = jsonMap['MasterID'].toString(),
        columnname = jsonMap['MasterName'].toString(),
        tablename = jsonMap['tablename'].toString();
}
