const String buildType = "staging";
//const String buildType = "production";

const double rawCardImageWidth = 265.0;
const double rawCardImageHeight = 370.0;
const double cardAspectRatio = rawCardImageWidth / rawCardImageHeight;
const int searchViewRatio = 1;
const int canvasViewRatio = 1;
const String imageUrlS3 = "https://magic-image-generator-card-images.s3.ap-northeast-1.amazonaws.com/";
const String cardMasterUrlS3 = ((buildType == "production") ?
"https://mig.ezway.link/cardmaster.csv" :
"https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster.csv");

const String cardMasterVersionUrlS3 = ((buildType == "production") ?
"https://mig.ezway.link/cardmasterVersion.json" :
"https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmasterVersion.json");

const rarityValueMap = {"common":0, "uncommon":1, "rare":2, "mythic":3,};
const sortItems = ["name", "cmc"];

const kofiUrl = "https://ko-fi.com/ezway";
const kofiIcon = "assets/images/icon_kofi.png";