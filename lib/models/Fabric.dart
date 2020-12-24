class Fabric {
  final String dia;
  final String diaid;
  final String fabricname;
  final String fabriccolor;
  final String fabcolorid;
  final String gsm;
  final String fabricmasterid;

  Fabric.fromJSON(Map<String, dynamic> jsonMap)
      : dia = jsonMap['dia'].toString(),
        diaid = jsonMap['diaid'].toString(),
        fabricname = jsonMap['fabricname'].toString(),
        fabriccolor = jsonMap['fabriccolor'].toString(),
        fabricmasterid = jsonMap['fabricmasterid'].toString(),
        fabcolorid = jsonMap['fabcolorid'].toString(),
        gsm = jsonMap['gsm'].toString();
}
