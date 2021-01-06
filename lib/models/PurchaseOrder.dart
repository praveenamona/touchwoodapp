class PurchaseOrderHeader {
  PurchaseOrderHeader(this.purchaseorderdetail);

  String headerid;
  String pono;
  String podate;

  List<PurchaseOrder> purchaseorderdetail;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'intHeaderID': headerid,
        'strPoNo': pono,
        'dtPoDate': podate,
        'yarn': purchaseorderdetail,
      };
}

class PurchaseOrder {
  String headerid;
  String yarnmillid;
  //   String
  String yarntypeid;
  String yarntype;
  String yarnmill;
  String yarncount;
  String yarncountid;
  String producttypeid;
  String producttype;
  String color;
  String uom;
  String dia;
  String knittype;
  String fabrictype;
  String fabric;
  String colorid;
  String composition;
  String compositionid;
  String uomid;
  String diaid;
  String knittypeid;
  String fabrictypeid;
  String fabricid;
  String lineid;
  String noofbox;
  String gsm;
  String weight;
  String kgsperbox;
  String rate;
  String amount;

  PurchaseOrder.fromJSON(Map<String, dynamic> jsonMap)
      : headerid = jsonMap['headerid'].toString(),
        yarnmillid = jsonMap['yarnmillid'].toString(),
        noofbox = jsonMap['noofbox'].toString(),
        gsm = jsonMap['gsm'].toString(),
        weight = jsonMap['weight'].toString(),
        kgsperbox = jsonMap['kgsperbox'].toString(),
        rate = jsonMap['rate'].toString(),
        amount = jsonMap['amount'].toString(),
        yarnmill = jsonMap['yarnmill'].toString(),
        yarntypeid = jsonMap['yarntypeid'].toString(),
        yarntype = jsonMap['yarntype'].toString(),
        yarncountid = jsonMap['yarncountid'].toString(),
        yarncount = jsonMap['yarncount'].toString(),
        producttypeid = jsonMap['producttypeid'].toString(),
        producttype = jsonMap['producttype'].toString(),
        colorid = jsonMap['colorid'].toString(),
        color = jsonMap['color'].toString(),
        uomid = jsonMap['uomid'].toString(),
        uom = jsonMap['uom'].toString(),
        compositionid = jsonMap['compositionid'].toString(),
        composition = jsonMap['composition'].toString(),
        diaid = jsonMap['diaid'].toString(),
        dia = jsonMap['dia'].toString(),
        knittypeid = jsonMap['knittypeid'].toString(),
        knittype = jsonMap['knittype'].toString(),
        fabrictypeid = jsonMap['fabrictypeid'].toString(),
        fabrictype = jsonMap['fabrictype'].toString(),
        fabricid = jsonMap['fabricid'].toString(),
        fabric = jsonMap['fabric'].toString(),
        lineid = jsonMap['lineid'].toString();
}
