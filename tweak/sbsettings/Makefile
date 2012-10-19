include theos/makefiles/common.mk

LIBRARY_NAME = LessADToggle
LessADToggle_FILES = Toggle.m
LessADToggle_FRAMEWORKS = UIKit CoreGraphics
LessADToggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/sbsettings/

include $(THEOS_MAKE_PATH)/library.mk

# internal-stage::
# 	$(ECHO_NOTHING)cp -r Themes $(THEOS_STAGING_DIR)/var/mobile/Library/SBSettings/$(ECHO_END)

# after-install::
# 	install.exec "killall SpringBoard"

