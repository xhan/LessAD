GO_EASY_ON_ME = 1
NO_TWEAK_RESPRING = 1
# This tells Theos not to treat warnings as errors. It removes the -Werror flag from the compiler arguments. We are ready to build the tweak!

include theos/makefiles/common.mk
INTERNAL_CFLAGS += -Wunused-variable
TWEAK_NAME = LessAD
LessAD_FILES = Tweak.xm ../shared/PLOG.m
LessAD_FRAMEWORKS = UIKit CoreGraphics QuartzCore Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += sbsettings
include $(THEOS_MAKE_PATH)/aggregate.mk

# the step before package
internal-stage::
	$(ECHO_NOTHING)cp -r ../build/ $(THEOS_STAGING_DIR)/Applications/$(ECHO_END)
	$(ECHO_NOTHING)rm -rf $(THEOS_STAGING_DIR)/Applications/*.dSYM$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)
