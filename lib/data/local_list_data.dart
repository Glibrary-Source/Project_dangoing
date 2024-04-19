
class LocalListData {
  static final LocalListData instance = LocalListData._internal();
  factory LocalListData()=>instance;
  LocalListData._internal();

  List<String> dropDownList = [
    "서울특별시",
    "강원도" ,
    "경기도" ,
    "세종특별자치시",
    "경상남도" ,
    "경상북도" ,
    "광주광역시" ,
    "대구광역시" ,
    "대전광역시" ,
    "부산광역시" ,
    // "세종특별자치시" ,
    "울산광역시" ,
    "인천광역시" ,
    "전라남도" ,
    "전라북도" ,
    "제주특별자치도" ,
    "충청남도" ,
    "충청북도"];

}