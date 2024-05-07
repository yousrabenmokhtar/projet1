class Transaction {
  String? id;
  final String nom;
  final DateTime date;
  final double montant;

  Transaction({
    this.id,
    required this.nom,
    required this.date,
    required this.montant,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id_transaction'],
      nom: map['nom'] as String,
      date: DateTime.parse(map['date_ajout']),
      montant: (map['montant'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'montant': montant,
    };
  }


  // String get transactionNom => nom;
 
  // double get transactionMontant => montant;


}