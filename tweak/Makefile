GO_EASY_ON_ME = 1
# This tells Theos not to treat warnings as errors. It removes the -Werror flag from the compiler arguments. We are ready to build the tweak!


include theos/makefiles/common.mk

TWEAK_NAME = LessAD
LessAD_FILES = Tweak.xm
LessAD_FRAMEWORKS = UIKit CoreGraphics QuartzCore Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += sbsettings
include $(THEOS_MAKE_PATH)/aggregate.mk


internal-stage::	
	$(ECHO_NOTHING)cp -r ../build/ $(THEOS_STAGING_DIR)/Applications/$(ECHO_END)