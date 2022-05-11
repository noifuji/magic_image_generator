flutter pub run build_runner build --delete-conflicting-outputs


flutter build web --release --web-renderer canvaskit

flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer canvaskit

flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0 --web-renderer html