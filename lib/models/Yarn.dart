class Yarn {
  final String counts;
  final String yarntype;
  final String yarnmill;
  final String yarncolor;
  final double kgsperbox;
  final String yarncountid;
  final String yarnmillid;
  final String yarncolorid;
  final String yarnmasterid;
  final String yarntypeid;

  Yarn.fromJSON(Map<String, dynamic> jsonMap)
      : counts = jsonMap['counts'].toString(),
        yarntype = jsonMap['yarntype'].toString(),
        yarnmill = jsonMap['yarnmill'].toString(),
        yarncolor = jsonMap['yarncolor'].toString(),
        yarncountid = jsonMap['yarncountid'].toString(),
        yarnmillid = jsonMap['yarnmillid'].toString(),
        yarncolorid = jsonMap['yarncolorid'].toString(),
        yarntypeid = jsonMap['yarntypeid'].toString(),
        yarnmasterid = jsonMap['yarnmasterid'].toString(),
        kgsperbox = jsonMap['kgsperbox'];
}
