BUILD_PATH = build

default:
	# @echo "please select commands"
	cd tweak && make

app:
	xcodebuild CONFIGURATION_BUILD_DIR=$(BUILD_PATH)

package:
	cd tweak && make package
	@# rm -rf $(BUILD_PATH)/*.deb
	@# cp "tweak/$(ls -l tweak | grep deb | tail -n1 | awk '{print $(NF)}')" $(BUILD_PATH)/

install:
	cd tweak && make install

all:app package install

clean:
	rm -rf $(BUILD_PATH)/*
	rm -rf tweak/*.deb
	cd tweak && make clean

# TARGET_CXX = xcrun --sdk iphoneos clang
