
class CategoryListData {

  static final CategoryListData instance = CategoryListData._internal();
  factory CategoryListData()=>instance;
  CategoryListData._internal();

  Map<String, String> categoryMap = {
    "문예회관" : "assets/icons/category/img_category_item_korea_gate.png",
    "카페": "assets/icons/category/img_category_item_korea_cafe.png",
    "미술관": "assets/icons/category/img_category_item_korea_art_gallery.png",
    "미용": "assets/icons/category/img_category_item_korea_petsalong.png",
    "박물관": "assets/icons/category/img_category_item_korea_museum.png",
    "반려동물용품": "assets/icons/category/img_category_item_korea_dog_tools.png",
    "식당": "assets/icons/category/img_category_item_korea_restaurant.png",
    "여행지": "assets/icons/category/img_category_item_korea_trip.png",
    "위탁관리": "assets/icons/category/img_category_item_korea_management.png",
    "펜션": "assets/icons/category/img_category_item_korea_rental_cottage.png"
  };

}