import '../DataStructures/Cocktail/CocktailCategoryEnum.dart';

class QueryOptions {

  QueryOptions({
    this.search,
    this.alcoholic,
    this.category,
    this.glass
  });

  String createPrompt(int page, int count) {
    String prompt = _apiDomain + "page=$page&perPage=$count";

    if(search != null && search != "") {
      prompt += "&name=%${Uri.encodeFull(search!)}%";
    }

    if(alcoholic != null) {
      prompt+="&alcoholic=$alcoholic";
    }

    if(category != null) {
      prompt+="&category=${Uri.encodeFull(category!)}";
    }

    if(glass != null) {
      prompt+="&glass=${Uri.encodeFull(glass!)}";
    }

    return prompt;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      print("identical");
      return true;
    }
      if (other is! QueryOptions) return false;

      return search == other.search
          && alcoholic == other.alcoholic
          && category == other.category
          && glass == other.glass;
  }

  QueryOptions clone() {
    return QueryOptions(
      search: search,
      alcoholic: alcoholic,
      category: category,
      glass: glass
    );
  }

  @override
  int get hashCode {
    return search.hashCode ^
    (alcoholic?.hashCode ?? 0) ^
    (category?.hashCode ?? 0) ^
    (glass?.hashCode ?? 0);
  }

  static const _apiDomain = "https://cocktails.solvro.pl/api/v1/cocktails?";
  String? search;
  bool? alcoholic;
  String? category;
  String? glass;
}