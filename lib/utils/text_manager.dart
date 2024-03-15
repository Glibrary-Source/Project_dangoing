

class TextManager {

  String checkRestDay(String item) {
    if(item == "") {
      return "정보 없음";
    } else {
      return item;
    }
  }

  String checkOpenTime(String item) {
    if(item == "") {
      return "정보 없음";
    } else {
      return item;
    }
  }

  String checkParking(String item) {
    if(item == "Y") {
      return "주차 가능";
    } else {
      return "주차 불가능";
    }
  }

}