class Granite {
  final String masterid;
  final String productcode;
  final String productname;
  final String group;
  final String groupid;
  final String uom;
  final String uomid;
  final String color;
  final String colorid;
  final String type;
  final String typeid;
  final String measurement;
  final String measurementid;

  Granite.fromJSON(Map<String, dynamic> jsonMap)
      : masterid = jsonMap['dia'].toString(),
        productcode = jsonMap['diaid'].toString(),
        productname = jsonMap['fabricname'].toString(),
        group = jsonMap['fabriccolor'].toString(),
        groupid = jsonMap['fabricmasterid'].toString(),
        uom = jsonMap['fabcolorid'].toString(),
        uomid = jsonMap['gsm'].toString(),
        color = jsonMap['color'].toString(),
        colorid = jsonMap['colorid'].toString(),
        type = jsonMap['fabcolorid'].toString(),
        typeid = jsonMap['fabcolorid'].toString(),
        measurement = jsonMap['fabcolorid'].toString(),
        measurementid = jsonMap['fabcolorid'].toString();
}
