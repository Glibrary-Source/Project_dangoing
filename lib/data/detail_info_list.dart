import 'package:project_dangoing/utils/text_manager.dart';

import '../vo/store_vo.dart';

class DetailInfoList {
  TextManager textManager;
  StoreVo data;

  DetailInfoList({
    required this.textManager,
    required this.data,
  });

  List<String> getInfoList() {
    List<String> infoData = [
      "휴일: ${textManager.checkRestDay(data.RSTDE_GUID_CN ?? " ")}",
      "주차: ${textManager.checkParking(data.PARKNG_POSBL_AT ?? " ")}",
      "내부 동반: ${textManager.checkInPlace(data.IN_PLACE_ACP_POSBL_AT ?? " ")}",
      "반려동물 크기: ${textManager.checkPetSize(data.ENTRN_POSBL_PET_SIZE_VALUE ?? " ")}",
      "반려동물 제한: ${textManager.checkPetLimit(data.PET_LMTT_MTR_CN ?? " ")}",
      "반려동물 추가요금: ${textManager.checkAddCharge(data.PET_ACP_ADIT_CHRGE_VALUE ?? " ")}"
    ];
    return infoData;
  }

  String getSharedText() {
    String urlExistedText =
        '\n\n휴일: ${textManager.checkRestDay(data.RSTDE_GUID_CN ?? "")}\n' +
        '주차: ${textManager.checkParking(data.PARKNG_POSBL_AT ?? "")}\n' +
        '내부 동반: ${textManager.checkInPlace(data.IN_PLACE_ACP_POSBL_AT ?? "")}\n' +
        '반려동물 크기: ${textManager.checkPetSize(data.ENTRN_POSBL_PET_SIZE_VALUE ?? "")}\n' +
        '반려동물 제한: ${textManager.checkPetLimit(data.PET_LMTT_MTR_CN ?? "")}\n' +
        '반려동물 추가요금: ${textManager.checkAddCharge(data.PET_ACP_ADIT_CHRGE_VALUE ?? "")}\n';

    String urlNotExistedText =
        '\n\n휴일: ${textManager.checkRestDay(data.RSTDE_GUID_CN ?? "")}\n' +
            '주차: ${textManager.checkParking(data.PARKNG_POSBL_AT ?? "")}\n' +
            '내부 동반: ${textManager.checkInPlace(data.IN_PLACE_ACP_POSBL_AT ?? "")}\n' +
            '반려동물 크기: ${textManager.checkPetSize(data.ENTRN_POSBL_PET_SIZE_VALUE ?? "")}\n' +
            '반려동물 제한: ${textManager.checkPetLimit(data.PET_LMTT_MTR_CN ?? "")}\n' +
            '반려동물 추가요금: ${textManager.checkAddCharge(data.PET_ACP_ADIT_CHRGE_VALUE ?? "")}\n'+
            '\n대표 홈페이지가 존재하지 않습니다.';

    if(data.HMPG_URL != "") {
      return urlExistedText;
    } else {
      return urlNotExistedText;
    }
  }
}
