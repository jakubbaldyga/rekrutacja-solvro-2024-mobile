

class Ingredient {
  Ingredient(this.id,
      this.name,
      this.description,
      this.alcohol,
      this.type,
      this.percentage,
      this.imageUrl,
      this.createdAt,
      this.updatedAt);

  final int id;
  final String name;
  final String description;
  final bool alcohol;
  final String type;
  final double percentage;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

}