class Data {
  String active;
  String confirmed;
  String deaths;
  String recovered;
  String state;
  String statecode;

  Data({
    this.active,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.state,
    this.statecode,
  });

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    state = json['state'];
    statecode = json['statecode'];
  }
}
