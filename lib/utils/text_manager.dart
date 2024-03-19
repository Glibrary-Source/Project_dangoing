

class TextManager {

  String checkRestDay(String item) {
    if(item == "") {
      return "휴일: 정보 없음";
    } else {
      return "휴일: $item";
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
      return "주차: 가능";
    } else {
      return "주차: 불가능";
    }
  }

  String checkInPlace(String item) {
    if(item == "Y") {
      return "내부 동반: 가능";
    } else {
      return "외부 동반: 불가능";
    }
  }

  String checkPetSize(String item) {
    if( item == "해당없음") {
      return "크기 제한: 모두 가능";
    } else {
      return "크기 제한: $item";
    }
  }

  String checkPetLimit(String item) {
    return "제한 사항: $item";
  }

  String checkAddCharge(String item) {
    return "반려동물 추가요금: $item";
  }

}