enum CocktailCategory {
  Cocktail,
  Ordinary_Drink,
  Punch_Party_Drink,
  Shake,
  Other_Unknown,
  Cocoa,
  Shot,
  Coffee_or_Tea,
  Homemade_Liqueur,
  Soft_Drink
}

const Map<CocktailCategory, String> cocktailToString = {
  CocktailCategory.Cocktail: "Cocktail",
  CocktailCategory.Ordinary_Drink: "Ordinary Drink",
  CocktailCategory.Punch_Party_Drink: "Punch / Party Drink",
  CocktailCategory.Shake: "Shake",
  CocktailCategory.Other_Unknown: "Other / Unknown",
  CocktailCategory.Cocoa: "Cocoa",
  CocktailCategory.Shot: "Shot",
  CocktailCategory.Coffee_or_Tea: "Coffee / Tea",
  CocktailCategory.Homemade_Liqueur: "Homemade Liqueur",
  CocktailCategory.Soft_Drink: "Soft Drink"
};

const Map<String, CocktailCategory> stringToCocktail = {
  "Cocktail" : CocktailCategory.Cocktail,
  "Ordinary Drink" : CocktailCategory.Ordinary_Drink,
  "Punch / Party Drink" : CocktailCategory.Punch_Party_Drink,
  "Shake" : CocktailCategory.Shake,
  "Other / Unknown" : CocktailCategory.Other_Unknown,
  "Cocoa" : CocktailCategory.Cocoa,
  "Shot" : CocktailCategory.Shot,
  "Coffee / Tea" : CocktailCategory.Coffee_or_Tea,
  "Homemade Liqueur" : CocktailCategory.Homemade_Liqueur,
  "Soft Drink" : CocktailCategory.Soft_Drink
};