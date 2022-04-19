class Stockopname {
  Stockopname({
    this.id,
    this.soId,
    this.warehouse,
    this.createdAt,
    this.createdBy,
    this.totalSoItem,
  });

  int? id;
  String? soId;
  String? warehouse;
  DateTime? createdAt;
  String? createdBy;
  int? totalSoItem;

  factory Stockopname.fromJson(Map<String, dynamic> json, {int? totalItem}) => Stockopname(
        id: json["id"],
        soId: json["so_id"],
        warehouse: json["warehouse"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        totalSoItem: totalItem ?? 0,
      );
}

List<Stockopname> stockopname = [
  Stockopname(
    id: 1,
    soId: "SO-001",
    warehouse: "Gudang 1",
    createdAt: DateTime.parse("2020-01-01 00:00:00"),
    createdBy: "Admin",
    totalSoItem: 100,
  ),
];
