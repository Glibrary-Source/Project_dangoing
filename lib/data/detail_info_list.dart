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
      textManager.checkRestDay(data.RSTDE_GUID_CN ?? ""),
      textManager.checkParking(data.PARKNG_POSBL_AT??""),
      textManager.checkInPlace(data.IN_PLACE_ACP_POSBL_AT??""),
      textManager.checkPetSize(data.ENTRN_POSBL_PET_SIZE_VALUE??""),
      textManager.checkPetLimit(data.PET_LMTT_MTR_CN??""),
      textManager.checkAddCharge(data.PET_ACP_ADIT_CHRGE_VALUE??"")
    ];
    return infoData;
  }



}
