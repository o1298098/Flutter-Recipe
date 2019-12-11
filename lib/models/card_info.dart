class CardInfo {
  int index;
  String backGroundUrl;
  String dishUrl;
  String name;
  String subName;
  String description;
  String cal;
  List<IngredientItem> ingredients;
  CardInfo(this.index, this.backGroundUrl, this.dishUrl, this.name,
      this.subName, this.description, this.cal, this.ingredients);
}

class IngredientItem {
  String icon;
  String name;
  IngredientItem(this.icon, this.name);
}
