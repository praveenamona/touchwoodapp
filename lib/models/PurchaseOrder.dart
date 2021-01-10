class PurchaseOrderHeader {
  PurchaseOrderHeader(
      {this.purchaseorderdetail,
      this.purchaseorderfabricdetail,
      this.headerid,
      this.pono,
      this.podate,
      this.producttype,
      this.consigneeid,
      this.supplierid,
      this.currencyid,
      this.noofcontainers,
      this.paymentterms,
      this.shipmentmodeid,
      this.portofloadingid,
      this.shipmentdate,
      this.packinglistid,
      this.remarks,
      this.termsandconditions});
  String headerid;
  String pono;
  String podate;
  String producttype;
  String consigneeid;
  String supplierid;
  String currencyid;
  String noofcontainers;
  String paymentterms;
  String shipmentmodeid;
  String portofloadingid;
  String shipmentdate;
  String packinglistid;
  String remarks;
  String termsandconditions;
  String userid;
  String notifypartyid;
  String notifyparty;
  String supplier;
  String consignee;
  String currency;
  String portofdischargeid;

  List<PurchaseOrderDetails> purchaseorderdetail;
  List<PurchaseOrderFabricDetails> purchaseorderfabricdetail;

  PurchaseOrderHeader.fromJSON(Map<String, dynamic> jsonMap)
      : headerid = jsonMap['HeaderID'].toString(),
        pono = jsonMap['PoNo'].toString(),
        podate = jsonMap['PoDate'].toString(),
        producttype = jsonMap['ProductType'].toString(),
        consigneeid = jsonMap['ConsigneeID'].toString(),
        consignee = jsonMap['Consignee'].toString(),
        notifypartyid = jsonMap['NotifyPartyID'].toString(),
        notifyparty = jsonMap['NotifyParty'].toString(),
        supplierid = jsonMap['SupplierID'].toString(),
        supplier = jsonMap['Supplier'].toString(),
        currencyid = jsonMap['CurrencyID'].toString(),
        currency = jsonMap['Currency'].toString(),
        noofcontainers = jsonMap['NoofContainers'].toString(),
        paymentterms = jsonMap['PaymentTerms'].toString(),
        portofdischargeid = jsonMap['PortOfDischargeID'].toString(),
        shipmentmodeid = jsonMap['ShipmenModeID'].toString(),
        portofloadingid = jsonMap['PortofLoadingID'].toString(),
        shipmentdate = jsonMap['ShipmentDate'].toString(),
        packinglistid = jsonMap['PackingDetailsID'].toString(),
        remarks = jsonMap['Remarks'].toString(),
        termsandconditions = jsonMap['TermsConditions1'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'spname': 'GetAndSubmitPODetails',
        'Mode': 'PO',
        'intFlag': '1',
        'intHeaderID': headerid,
        'strPoNo': pono,
        'dtPoDate': podate,
        'strProductType': producttype,
        'intConsigneeID': consigneeid,
        'intSupplierID': supplierid,
        'intCurrencyID': currencyid,
        'intNoofContainers': noofcontainers,
        'strPaymentTerms': paymentterms,
        'intShipmenModeID': shipmentmodeid,
        'intPortofLoadingID': portofloadingid,
        'intShipmentDate': '1',
        'intPackingDetailsID': packinglistid,
        'strRemarks': "remarks",
        'strTermsConditions1': termsandconditions,
        'strTermsConditions2': '1',
        'strTermsConditions3': '1',
        'strTermsConditions4': '1',
        'strTermsConditions5': '1',
        'strTermsConditions6': '1',
        'strTermsConditions7': '1',
        'strTermsConditions8': '1',
        'intUserID': '1',
        'yarn': purchaseorderdetail,
        'fabric': purchaseorderfabricdetail
      };
}

class PurchaseOrderFabricDetails {
  PurchaseOrderFabricDetails({
    this.headerid,
    this.colorid,
    this.noofbox,
    this.weight,
    this.rate,
    this.amount,
    this.fabrictypeid,
    this.fabricid,
    this.compositionid,
    this.gsm,
    this.diaid,
    this.knittypeid,
    this.uomid,
  });
  String colorid;
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
  String remarks;
  String sortnumber;
  String detailid;
  String headerid;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Mode': 'fabric',
        'spname': 'GetAndSubmitPOFabricDetails',
        'intFlag': '1',
        'intPurchaseOrdeFabricrDetailID': '1',
        'intHeaderID': headerid,
        'intFabricTypeID': fabrictypeid,
        'strSortNumber': '23',
        'intFabricID': fabricid,
        'intCompositionID': compositionid,
        'intColorID': colorid,
        'intGsm': gsm,
        'intDiaID': diaid,
        'intFabricKnitTypeID': knittypeid,
        'intUomID': uomid,
        'intNoofBox': noofbox,
        'intKgsperbox': '200',
        'intWeight': weight,
        'intRate': rate,
        'intAmount': amount,
        'strRemarks': remarks,
        'intUserID': '200'
      };
}

class PurchaseOrderDetails {
  PurchaseOrderDetails({
    this.headerid,
    this.yarnmillid,
    this.yarntypeid,
    this.yarncountid,
    this.colorid,
    this.noofbox,
    this.weight,
    this.rate,
    this.amount,
    this.fabrictypeid,
    this.fabricid,
    this.compositionid,
    this.gsm,
    this.diaid,
    this.knittypeid,
    this.uomid,
  });

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
  String remarks;
  String sortnumber;
  String detailid;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Mode': 'yarn',
        'spname': 'GetAndSubmitPOYarnDetail',
        'intFlag': '1',
        'PurchaseOrdeYarnrDetailID': '1',
        'intHeaderID': headerid,
        'intYarnCountID': yarncountid,
        'intYarnMillID': yarnmillid,
        'intYarnColorID': colorid,
        'intNoofBox': noofbox,
        'intWeight': weight,
        'intRate': rate,
        'intAmount': amount,
        'intUserID': '1'
      };

  PurchaseOrderDetails.fromyarnJSON(Map<String, dynamic> jsonMap)
      : headerid = jsonMap['HeaderID'].toString(),
        yarncountid = jsonMap['YarnCountID'].toString(),
        yarnmillid = jsonMap['YarnMillID'].toString(),
        colorid = jsonMap['YarnColorID'].toString(),
        yarncount = jsonMap['YarnCount'].toString(),
        yarnmill = jsonMap['YarnMill'].toString(),
        color = jsonMap['YarnColor'].toString(),
        noofbox = jsonMap['NoofBox'].toString(),
        weight = jsonMap['Weight'].toString(),
        kgsperbox = jsonMap['Kgsperbox'].toString(),
        rate = jsonMap['Rate'].toString(),
        amount = jsonMap['Amount'].toString();

  PurchaseOrderDetails.fromJSON(Map<String, dynamic> jsonMap)
      : headerid = jsonMap['headerid'].toString(),
        noofbox = jsonMap['NoofBox'].toString(),
        gsm = jsonMap['gsm'].toString(),
        weight = jsonMap['Weight'].toString(),
        kgsperbox = jsonMap['Kgsperbox'].toString(),
        rate = jsonMap['Rate'].toString(),
        amount = jsonMap['Amount'].toString(),
        colorid = jsonMap['ColorID'].toString(),
        color = jsonMap['Color'].toString(),
        uomid = jsonMap['UomID'].toString(),
        uom = jsonMap['Uom'].toString(),
        compositionid = jsonMap['CompositionID'].toString(),
        composition = jsonMap['Composition'].toString(),
        diaid = jsonMap['DiaID'].toString(),
        dia = jsonMap['Dia'].toString(),
        knittypeid = jsonMap['FabricKnitTypeID'].toString(),
        knittype = jsonMap['FabricKnitType'].toString(),
        fabrictypeid = jsonMap['FabricTypeID'].toString(),
        fabrictype = jsonMap['FabricType'].toString(),
        fabricid = jsonMap['FabricID'].toString(),
        fabric = jsonMap['fabric'].toString(),
        lineid = jsonMap['lineid'].toString();
}
