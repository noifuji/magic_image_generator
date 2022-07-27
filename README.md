- Isarファイル生成
flutter pub run build_runner build --delete-conflicting-outputs

- デバッグ 
flutter run -d chrome --web-renderer canvaskit --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false --profile

- ビルド
flutter build web --release --web-renderer canvaskit

!!!!!!!!Flutter3.0のバグが修正されるまではこのコマンドでビルドする!!!!!!!!!!!
flutter build web --release --web-renderer canvaskit　--dart-define=BROWSER_IMAGE_DECODING_ENABLED=false
詳細はこちら　https://github.com/flutter/flutter/issues/103803


- ローカルにサーバーたてて実行(スマホ検証用)
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer canvaskit
flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer html

- AWSアップロード(Staging)
aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-staging/  --profile=PROFILE_NAME


- CloudFront invalidate 
aws cloudfront create-invalidation --distribution-id E2YAUEENNV3LHC --paths "/*"






- AWSアップロード(Production)
  aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-production/  --profile=PROFILE_NAME