.PHONY: rebuild build_run build_apk

rebuild:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
	fvm flutter clean
	fvm flutter pub get

build_run:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

build_apk:
	flutter build apk --release