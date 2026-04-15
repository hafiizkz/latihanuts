class Narapidana {
  String id;
  String nama;
  String jk;
  String umur;
  String kasus;

  Narapidana({
    required this.id,
    required this.nama,
    required this.jk,
    required this.umur,
    required this.kasus,
  });

  factory Narapidana.fromMap(String key, Map data) {
    return Narapidana(
      id: key,
      nama: data['nama'],
      jk: data['jk'],
      umur: data['umur'],
      kasus: data['kasus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "jk": jk,
      "umur": umur,
      "kasus": kasus,
    };
  }
}