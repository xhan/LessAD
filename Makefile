app:
	@rm -rf build/*
	xcodebuild CONFIGURATION_BUILD_DIR=build
	