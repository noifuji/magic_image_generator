import 'package:flutter/widgets.dart';
import 'package:magic_image_generator/common/search_filter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchFilterFactory {
  static SearchFilterData createSearchFilter(
      BuildContext context, SearchFilter sf) {
    /****Rarities****/
    if (sf == SearchFilter.rarityCommon) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.rarityCommon,
          searchValue: "c",
          searchKey: "r",
          filterType: SearchFilterType.rarity);
    } else if (sf == SearchFilter.rarityUncommon) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.rarityUncommon,
          searchValue: "u",
          searchKey: "r",
          filterType: SearchFilterType.rarity);
    } else if (sf == SearchFilter.rarityRare) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.rarityRare,
          searchValue: "r",
          searchKey: "r",
          filterType: SearchFilterType.rarity);
    } else if (sf == SearchFilter.rarityMythic) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.rarityMythic,
          searchValue: "m",
          searchKey: "r",
          filterType: SearchFilterType.rarity);
    }

    /****Colors****/
    else if (sf == SearchFilter.colorWhite) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "w",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorBlue) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "u",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorBlack) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "b",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorRed) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "r",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorGreen) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "g",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorColorless) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "colorless",
          searchKey: "c",
          filterType: SearchFilterType.color);
    } else if (sf == SearchFilter.colorMulti) {
      return SearchFilterData(
          filter: sf,
          name: "",
          searchValue: "m",
          searchKey: "c",
          filterType: SearchFilterType.color);
    }

    /****Card Types****/
    else if (sf == SearchFilter.typeArtifact) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeArtifact,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeArtifact,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeCreature) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeCreature,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeCreature,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeEnchantment) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeEnchantment,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeEnchantment,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeInstant) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeInstant,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeInstant,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeLand) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeLand,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeLand,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typePlaneswalker) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typePlaneswalker,
          searchValue: AppLocalizations.of(context)!.searchKeyTypePlaneswalker,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeSorcery) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeSorcery,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeSorcery,
          searchKey: "t",
          filterType: SearchFilterType.type);
    } else if (sf == SearchFilter.typeBattle) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.typeBattle,
          searchValue: AppLocalizations.of(context)!.searchKeyTypeBattle,
          searchKey: "t",
          filterType: SearchFilterType.type);
    }

    /****Cmcs****/
    else if (sf == SearchFilter.manaValue0) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue0,
          searchValue: "0",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue1) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue1,
          searchValue: "1",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue2) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue2,
          searchValue: "2",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue3) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue3,
          searchValue: "3",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue4) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue4,
          searchValue: "4",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue5) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue5,
          searchValue: "5",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue6) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue6,
          searchValue: "6",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    } else if (sf == SearchFilter.manaValue7AndMore) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.manaValue7AndMore,
          searchValue: "7",
          searchKey: "cmc",
          filterType: SearchFilterType.cmc);
    }

    /****Sets****/
    else if (sf == SearchFilter.setMkm) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setMkm,
          searchValue: "mkm",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setLci) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setLci,
          searchValue: "lci",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setWoe) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setWoe,
          searchValue: "woe",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setMat) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setMat,
          searchValue: "mat",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }  else if (sf == SearchFilter.setMom) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setMom,
          searchValue: "mom",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setOne) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setOne,
          searchValue: "one",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }  else if (sf == SearchFilter.setBro) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setBro,
          searchValue: "bro",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setDmu) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setDmu,
          searchValue: "dmu",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setSnc) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setSnc,
          searchValue: "snc",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setNeo) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setNeo,
          searchValue: "neo",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setVow) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setVow,
          searchValue: "vow",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setMid) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setMid,
          searchValue: "mid",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setAfr) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setAfr,
          searchValue: "afr",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setStx) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setStx,
          searchValue: "stx",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setKhm) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setKhm,
          searchValue: "khm",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setZnr) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setZnr,
          searchValue: "znr",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setM21) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setM21,
          searchValue: "m21",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setIko) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setIko,
          searchValue: "iko",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setThb) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setThb,
          searchValue: "thb",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setEld) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setEld,
          searchValue: "eld",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setM20) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setM20,
          searchValue: "m20",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setWar) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setWar,
          searchValue: "war",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setRna) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setRna,
          searchValue: "rna",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setGrn) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setGrn,
          searchValue: "grn",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setM19) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setM19,
          searchValue: "m19",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setDom) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setDom,
          searchValue: "dom",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setRix) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setRix,
          searchValue: "rix",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setXln) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setXln,
          searchValue: "xln",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setHou) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHou,
          searchValue: "hou",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setEmn) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setEmn,
          searchValue: "emn",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setOri) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setOri,
          searchValue: "ori",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setM15) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setM15,
          searchValue: "m15",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setM14) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setM14,
          searchValue: "m14",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setAkh) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setAkh,
          searchValue: "akh",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setSoi) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setSoi,
          searchValue: "soi",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setDtk) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setDtk,
          searchValue: "dtk",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setJou) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setJou,
          searchValue: "jou",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setDgm) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setDgm,
          searchValue: "dgm",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setAer) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setAer,
          searchValue: "aer",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setOgw) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setOgw,
          searchValue: "ogw",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setFrf) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setFrf,
          searchValue: "frf",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setBng) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setBng,
          searchValue: "bng",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setGtc) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setGtc,
          searchValue: "gtc",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setKld) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setKld,
          searchValue: "kld",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setBfz) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setBfz,
          searchValue: "bfz",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setKtk) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setKtk,
          searchValue: "ktk",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setThs) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setThs,
          searchValue: "ths",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setRtr) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setRtr,
          searchValue: "rtr",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }

    /****Sets Alchemy****/
    else if (sf == SearchFilter.setYmkm) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYmkm,
          searchValue: "ymkm",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setYlci) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYlci,
          searchValue: "ylci",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setYwoe) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYwoe,
          searchValue: "ywoe",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setLtr) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setLtr,
          searchValue: "ltr",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYone) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYone,
          searchValue: "yone",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYbro) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYbro,
          searchValue: "ybro",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYdmu) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYdmu,
          searchValue: "ydmu",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setHbg) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHbg,
          searchValue: "hbg",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYSnc) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYSnc,
          searchValue: "ysnc",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYNeo) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYNeo,
          searchValue: "yneo",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setYMid) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setYMid,
          searchValue: "ymid",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }

    /****Sets Supplemental****/
    else if (sf == SearchFilter.setWot) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setWot,
          searchValue: "wot",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setMul) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setMul,
          searchValue: "mul",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setSis) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setSis,
          searchValue: "sis",
          searchKey: "set",
          filterType: SearchFilterType.set);
    } else if (sf == SearchFilter.setBrr) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setBrr,
          searchValue: "brr",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setJ21) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setJ21,
          searchValue: "j21",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setSta) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setSta,
          searchValue: "sta",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setJmp) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setJmp,
          searchValue: "jmp",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa7) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa7,
          searchValue: "ha7",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa6) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa6,
          searchValue: "ha6",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa5) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa5,
          searchValue: "ha5",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa4) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa4,
          searchValue: "ha4",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa3) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa3,
          searchValue: "ha3",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa2) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa2,
          searchValue: "ha2",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setHa1) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setHa1,
          searchValue: "ha1",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }
    else if (sf == SearchFilter.setAnb) {
      return SearchFilterData(
          filter: sf,
          name: AppLocalizations.of(context)!.setAnb,
          searchValue: "anb",
          searchKey: "set",
          filterType: SearchFilterType.set);
    }

    throw Exception();
  }
}

class SearchFilterData {
  SearchFilter filter;
  String name;
  String searchValue;
  String searchKey;
  SearchFilterType filterType;

  SearchFilterData(
      {required this.filter,
      required this.name,
      required this.searchValue,
      required this.searchKey,
      required this.filterType});
}

enum SearchFilterType { rarity, color, type, cmc, set }
