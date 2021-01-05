class PurchaseOrder {
  final String headerid;
  final String yarnmillid;
  //final String
  final String yarntypeid;
  final String yarncountid;
  final String producttypeid;
  final String colorid;
  final String uomid;
  final String diaid;
  final String knittypeid;
  final String fabrictypeid;
  final String fabricid;
  final String lineid;

  PurchaseOrder.fromJSON(Map<String, dynamic> jsonMap)
      : headerid = jsonMap['dia'].toString(),
        yarnmillid = jsonMap['diaid'].toString(),
        yarntypeid = jsonMap['fabricname'].toString(),
        yarncountid = jsonMap['fabriccolor'].toString(),
        producttypeid = jsonMap['fabricmasterid'].toString(),
        colorid = jsonMap['fabcolorid'].toString(),
        uomid = jsonMap['gsm'].toString(),
        diaid = jsonMap['color'].toString(),
        knittypeid = jsonMap['colorid'].toString(),
        fabrictypeid = jsonMap['fabcolorid'].toString(),
        fabricid = jsonMap['fabcolorid'].toString(),
        lineid = jsonMap['fabcolorid'].toString();
}
