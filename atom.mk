
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := eigen
LOCAL_DESCRIPTION := C++ template library for linear algebra
LOCAL_CATEGORY_PATH := libs

LOCAL_EXPORT_CFLAGS := \
	-DEIGEN_MPL2_ONLY \
	-DEIGEN_QUATERNIONBASE_PLUGIN=\"QuaternionBaseAddons.hpp\"

# Do not warn about uses of deprecated std::bind2nd
LOCAL_EXPORT_CXXFLAGS := \
	-Wno-deprecated-declarations

EIGEN_MACRO_FILE := $(LOCAL_PATH)/Eigen/src/Core/util/Macros.h
EIGEN_PC_IN_FILE := $(LOCAL_PATH)/eigen3.pc.in
EIGEN_INSTALL_PC_FILE := $(TARGET_AUTOTOOLS_INSTALL_DESTDIR)$(TARGET_AUTOTOOLS_CONFIGURE_PREFIX)/lib/pkgconfig/eigen3.pc
EIGEN_INSTALL_INCLUDE_DIR := $(TARGET_AUTOTOOLS_INSTALL_DESTDIR)$(TARGET_AUTOTOOLS_CONFIGURE_PREFIX)/include/eigen3

# Install in staging dir so alchemy sdk works (some header don't have extension)
# and other external modules can find them as well.
# Extract version from Macros.h file
# Install eigen3.pc from eigen3.pc.in by replacing version and instal dir.
# Install headers excuding some files/dirs
define LOCAL_CMD_INSTALL
	@mkdir -p $(dir $(EIGEN_INSTALL_PC_FILE))
	@mkdir -p $(EIGEN_INSTALL_INCLUDE_DIR)
	$(Q) ( \
		WORLD=`sed -n -e "s!\#define EIGEN_WORLD_VERSION *\(.*\)!\1!p" $(EIGEN_MACRO_FILE)`; \
		MAJOR=`sed -n -e "s!\#define EIGEN_MAJOR_VERSION *\(.*\)!\1!p" $(EIGEN_MACRO_FILE)`; \
		MINOR=`sed -n -e "s!\#define EIGEN_MINOR_VERSION *\(.*\)!\1!p" $(EIGEN_MACRO_FILE)`; \
		VERSION="$$WORLD.$$MAJOR.$$MINOR"; \
		sed -e "s!\$${EIGEN_VERSION_NUMBER}!$${VERSION}!" \
			-e "s!\$${INCLUDE_INSTALL_DIR}!$(TARGET_AUTOTOOLS_CONFIGURE_PREFIX)/include/eigen3!" \
			$(EIGEN_PC_IN_FILE) > $(EIGEN_INSTALL_PC_FILE); \
	)
	$(Q) rsync -a --exclude='*.txt' \
		$(call path-from-top,$(PRIVATE_PATH)/Eigen) \
		$(call path-from-top,$(EIGEN_INSTALL_INCLUDE_DIR))
	$(Q) rsync -a --exclude='*.txt' --exclude='bench' --exclude='doc' --exclude='test' \
		$(call path-from-top,$(PRIVATE_PATH)/unsupported) \
		$(call path-from-top,$(EIGEN_INSTALL_INCLUDE_DIR))
	$(Q) cp -af $(PRIVATE_PATH)/QuaternionBaseAddons.hpp $(EIGEN_INSTALL_INCLUDE_DIR)
endef

LOCAL_CLEAN_FILES += $(EIGEN_INSTALL_PC_FILE)
LOCAL_CLEAN_DIRS += $(EIGEN_INSTALL_INCLUDE_DIR)

LOCAL_EXPORT_C_INCLUDES := $(EIGEN_INSTALL_INCLUDE_DIR)

include $(BUILD_CUSTOM)
