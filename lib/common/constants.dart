import 'package:magic_image_generator/common/search_filter.dart';

enum Environment {development, staging, production}
const Map<String,Environment> envMap = {"dev":Environment.development, "stg":Environment.staging, "prd":Environment.production};

const double rawCardImageWidth = 265.0;
const double rawCardImageHeight = 370.0;
const double cardAspectRatio = rawCardImageWidth / rawCardImageHeight;
const int searchViewRatio = 1;
const int canvasViewRatio = 1;
const String imageUrlS3 = "https://magic-image-generator-card-images.s3.ap-northeast-1.amazonaws.com/";

const String cardMasterUrlS3Dev = "https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster.csv.gz";
const String cardMasterUrlS3Stg = "https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster.csv.gz";
const String cardMasterUrlS3Prd = "https://mig.ezway.link/cardmaster.csv.gz";

const String cardMasterVersionUrlS3Dev = "https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmasterVersion.json";
const String cardMasterVersionUrlS3Stg = "https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmasterVersion.json";
const String cardMasterVersionUrlS3Prd = "https://mig.ezway.link/cardmasterVersion.json";

const rarityValueMap = {"common":0, "uncommon":1, "rare":2, "mythic":3,};
const sortItems = ["name", "cmc"];

const kofiUrl = "https://ko-fi.com/ezway";
const kofiIcon = "assets/images/icon_kofi.png";

const Map<SearchFilter, String> searchFilterColorImagePath = {
  SearchFilter.colorWhite : "assets/images/white.png",
  SearchFilter.colorBlue : "assets/images/blue.png",
  SearchFilter.colorBlack : "assets/images/black.png",
  SearchFilter.colorRed : "assets/images/red.png",
  SearchFilter.colorGreen : "assets/images/green.png",
  SearchFilter.colorColorless : "assets/images/colorless.png",
  SearchFilter.colorMulti : "assets/images/multi.png"};


enum ArenaDeckListGroup { main, sideboard, companion, commander, none }
const String arenaDeckListKeyName = 'name';
const String arenaDeckListKeyQuantity = 'qry';
const String arenaDeckListKeySetCode = 'set';
const String arenaDeckListKeyNo = 'no';
const String arenaDeckListKeyGroup = 'group';