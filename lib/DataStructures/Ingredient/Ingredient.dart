
class Ingredient {
  Ingredient(this.id,
      this.name,
      this.description,
      this.alcohol,
      this.type,
      this.percentage,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.measure);


  final int id;
  final String name;
  final String? description;
  final bool? alcohol;
  final String? type;
  final int? percentage;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? measure;

  factory Ingredient.fromJson(json) {
      return Ingredient(
          json['id'],
          json['name'],
          json['description'],
          json['alcohol'],
          json['type'],
          json['percentage'],
          json['imageUrl'],
          DateTime.parse(json['createdAt']),
          DateTime.parse(json['updatedAt']),
          json['measure']);
  }
}