const double cardWidth = 265.0;
const double cardHeight = 370.0;
const int searchViewRatio = 3;
const int canvasViewRatio = 2;
const String imageUrlS3 = "https://magic-image-generator-card-images.s3.ap-northeast-1.amazonaws.com/";
const String cardMasterUrlS3 = "https://magic-image-generator-staging.s3.ap-northeast-1.amazonaws.com/cardmaster.csv";

const rarityLetterMap = {"c":"common", "u":"uncommon", "r":"rare", "m":"mythic"};
const rarityValueMap = {"common":0, "uncommon":1, "rare":2, "mythic":3,};