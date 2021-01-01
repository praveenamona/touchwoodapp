class Uom {
  final String columnMasterid;
  final String columnname;
  final String noofDecimal;

  Uom({this.columnMasterid, this.columnname, this.noofDecimal});
  Uom.fromJSON(Map<String, dynamic> jsonMap)
      : columnMasterid = jsonMap['UomMasterID'].toString(),
        columnname = jsonMap['Uom'].toString(),
        noofDecimal = jsonMap['NoofDecimal'].toString();
}
