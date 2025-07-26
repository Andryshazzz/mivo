.PHONY: rebuild buildrun

rebuild:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
	fvm flutter clean
	fvm flutter pub get

buildrun:
	fvm flutter pub run build_runner build --delete-conflicting-outputs