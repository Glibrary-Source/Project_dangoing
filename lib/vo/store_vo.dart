
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreVo {
  dynamic BULD_NO;
  String? CTGRY_ONE_NM;
  String? CTGRY_THREE_NM;
  String? CTGRY_TWO_NM;
  String? CTPRVN_NM;
  String? DOC_ID;
  String? ENTRN_POSBL_PET_SIZE_VALUE;
  String? FCLTY_INFO_DC;
  String? FCLTY_NM;
  String? HMPG_URL;
  String? IN_PLACE_ACP_POSBL_AT;
  num? LAST_UPDT_DE;
  double? LC_LA;
  double? LC_LO;
  String? LEGALDONG_NM;
  String? LI_NM;
  String? LNBR_NO;
  String? LNM_ADDR;
  String? OPER_TIME;
  String? OUT_PLACE_ACP_POSBL_AT;
  String? PARKNG_POSBL_AT;
  String? PET_ACP_ADIT_CHRGE_VALUE;
  String? PET_INFO_CN;
  String? PET_LMTT_MTR_CN;
  String? PET_POSBL_AT;
  String? RDNMADR_NM;
  String? ROAD_NM;
  String? RSTDE_GUID_CN;
  String? SIGNGU_NM;
  dynamic TEL_NO;
  String? UTILIIZA_PRC_CN;
  dynamic ZIP_NO;

  StoreVo({
    this.BULD_NO,
    this.CTGRY_ONE_NM,
    this.CTGRY_THREE_NM,
    this.CTGRY_TWO_NM,
    this.CTPRVN_NM,
    this.DOC_ID,
    this.ENTRN_POSBL_PET_SIZE_VALUE,
    this.FCLTY_INFO_DC,
    this.FCLTY_NM,
    this.HMPG_URL,
    this.IN_PLACE_ACP_POSBL_AT,
    this.LAST_UPDT_DE,
    this.LC_LA,
    this.LC_LO,
    this.LEGALDONG_NM,
    this.LI_NM,
    this.LNBR_NO,
    this.LNM_ADDR,
    this.OPER_TIME,
    this.OUT_PLACE_ACP_POSBL_AT,
    this.PARKNG_POSBL_AT,
    this.PET_ACP_ADIT_CHRGE_VALUE,
    this.PET_INFO_CN,
    this.PET_LMTT_MTR_CN,
    this.PET_POSBL_AT,
    this.RDNMADR_NM,
    this.ROAD_NM,
    this.RSTDE_GUID_CN,
    this.SIGNGU_NM,
    this.TEL_NO,
    this.UTILIIZA_PRC_CN,
    this.ZIP_NO
  });

  StoreVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    BULD_NO = documentSnapshot['BULD_NO'];
    CTGRY_ONE_NM = documentSnapshot['CTGRY_ONE_NM'];
    CTGRY_THREE_NM = documentSnapshot['CTGRY_THREE_NM'];
    CTGRY_TWO_NM = documentSnapshot['CTGRY_TWO_NM'];
    CTPRVN_NM = documentSnapshot['CTPRVN_NM'];
    DOC_ID = documentSnapshot['DOC_ID'];
    ENTRN_POSBL_PET_SIZE_VALUE = documentSnapshot['ENTRN_POSBL_PET_SIZE_VALUE'];
    FCLTY_INFO_DC = documentSnapshot['FCLTY_INFO_DC'];
    FCLTY_NM = documentSnapshot['FCLTY_NM'];
    HMPG_URL = documentSnapshot['HMPG_URL'];
    IN_PLACE_ACP_POSBL_AT = documentSnapshot['IN_PLACE_ACP_POSBL_AT'];
    LAST_UPDT_DE = documentSnapshot['LAST_UPDT_DE'];
    LC_LA = documentSnapshot['LC_LA'];
    LC_LO = documentSnapshot['LC_LO'];
    LEGALDONG_NM = documentSnapshot['LEGALDONG_NM'];
    LI_NM = documentSnapshot['LI_NM'];
    LNBR_NO = documentSnapshot['LNBR_NO'];
    LNM_ADDR = documentSnapshot['LNM_ADDR'];
    OPER_TIME = documentSnapshot['OPER_TIME'];
    OUT_PLACE_ACP_POSBL_AT = documentSnapshot['OUT_PLACE_ACP_POSBL_AT'];
    PARKNG_POSBL_AT = documentSnapshot['PARKNG_POSBL_AT'];
    PET_ACP_ADIT_CHRGE_VALUE = documentSnapshot['PET_ACP_ADIT_CHRGE_VALUE'];
    PET_INFO_CN = documentSnapshot['PET_INFO_CN'];
    PET_LMTT_MTR_CN = documentSnapshot['PET_LMTT_MTR_CN'];
    PET_POSBL_AT = documentSnapshot['PET_POSBL_AT'];
    RDNMADR_NM = documentSnapshot['RDNMADR_NM'];
    ROAD_NM = documentSnapshot['ROAD_NM'];
    RSTDE_GUID_CN = documentSnapshot['RSTDE_GUID_CN'];
    SIGNGU_NM = documentSnapshot['SIGNGU_NM'];
    TEL_NO = documentSnapshot['TEL_NO'];
    UTILIIZA_PRC_CN = documentSnapshot['UTILIIZA_PRC_CN'];
    ZIP_NO = documentSnapshot['ZIP_NO'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['BULD_NO'] = BULD_NO??"";
    data['CTGRY_ONE_NM'] = CTGRY_ONE_NM??"";
    data['CTGRY_THREE_NM'] = CTGRY_THREE_NM??"";
    data['CTGRY_TWO_NM'] = CTGRY_TWO_NM??"";
    data['CTPRVN_NM'] = CTPRVN_NM??"";
    data['DOC_ID'] = DOC_ID??"";
    data['ENTRN_POSBL_PET_SIZE_VALUE'] = ENTRN_POSBL_PET_SIZE_VALUE??"";
    data['FCLTY_INFO_DC'] = FCLTY_INFO_DC??"";
    data['FCLTY_NM'] = FCLTY_NM??"";
    data['HMPG_URL'] = HMPG_URL??"";
    data['IN_PLACE_ACP_POSBL_AT'] = IN_PLACE_ACP_POSBL_AT??"";
    data['LAST_UPDT_DE'] = LAST_UPDT_DE??"";
    data['LC_LA'] = LC_LA??"";
    data['LC_LO'] = LC_LO??"";
    data['LEGALDONG_NM'] = LEGALDONG_NM??"";
    data['LI_NM'] = LI_NM??"";
    data['LNBR_NO'] = LNBR_NO??"";
    data['LNM_ADDR'] = LNM_ADDR??"";
    data['OPER_TIME'] = OPER_TIME??"";
    data['OUT_PLACE_ACP_POSBL_AT'] = OUT_PLACE_ACP_POSBL_AT??"";
    data['PARKNG_POSBL_AT'] = PARKNG_POSBL_AT??"";
    data['PET_ACP_ADIT_CHRGE_VALUE'] = PET_ACP_ADIT_CHRGE_VALUE??"";
    data['PET_INFO_CN'] = PET_INFO_CN??"";
    data['PET_LMTT_MTR_CN'] = PET_LMTT_MTR_CN??"";
    data['PET_POSBL_AT'] = PET_POSBL_AT??"";
    data['RDNMADR_NM'] = RDNMADR_NM??"";
    data['ROAD_NM'] = ROAD_NM??"";
    data['RSTDE_GUID_CN'] = RSTDE_GUID_CN??"";
    data['SIGNGU_NM'] = SIGNGU_NM??"";
    data['TEL_NO'] = TEL_NO??"";
    data['UTILIIZA_PRC_CN'] = UTILIIZA_PRC_CN??"";
    data['ZIP_NO'] = ZIP_NO??"";
    return data;
  }

}