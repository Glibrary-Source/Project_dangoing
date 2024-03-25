

class TextManager {

  String checkAddress(String item) {
    if(item == "") {
      return "주소정보 없음";
    } else {
      return "$item";
    }
  }

  String checkCategory(String item) {
    if(item == "") {
      return "카테고리 없음";
    } else {
      return "$item";
    }
  }

  String checkRestDay(String item) {
    if(item == "") {
      return "정보 없음";
    } else {
      return "$item";
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

  String checkInPlace(String item) {
    if(item == "Y") {
      return "내부동반 가능";
    } else {
      return "내부동반 불가능";
    }
  }

  String checkPetSize(String item) {
    if( item == "해당없음") {
      return "모두 가능";
    } else {
      return "$item";
    }
  }

  String checkPetLimit(String item) {
    return "$item";
  }

  String checkAddCharge(String item) {
    return "$item";
  }

}