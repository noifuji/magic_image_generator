.PHONY: clean
clean:
	fvm flutter clean
	fvm flutter pub get

run:
	fvm flutter run -d chrome --web-renderer canvaskit --dart-define=ENV=stg --web-port=42638

deploy-stg:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build web --wasm --release --dart-define=ENV=stg
	aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-staging/  --profile=PROFILE_NAME

deploy-prd:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build web --wasm --release --dart-define=ENV=prd
	aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-production/  --profile=PROFILE_NAME
	aws cloudfront create-invalidation --distribution-id E2YAUEENNV3LHC --paths "/*"