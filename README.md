flutter pub run build_runner build --delete-conflicting-outputs


flutter build web --release --web-renderer canvaskit

flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer canvaskit

flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer html

aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-staging/  --profile=PROFILE_NAME












aws --region ap-northeast-1 s3 sync ./build/web s3://magic-image-generator-production/  --profile=PROFILE_NAME