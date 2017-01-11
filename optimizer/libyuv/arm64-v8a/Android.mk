# This is the Android makefile for libyuv for both platform and NDK.
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc

LOCAL_SRC_FILES := \
    source/compare.cc           \
    source/compare_common.cc    \
    source/compare_neon64.cc    \
    source/compare_gcc.cc       \
    source/convert.cc           \
    source/convert_argb.cc      \
    source/convert_from.cc      \
    source/convert_from_argb.cc \
    source/convert_to_argb.cc   \
    source/convert_to_i420.cc   \
    source/cpu_id.cc            \
    source/planar_functions.cc  \
    source/rotate.cc            \
    source/rotate_any.cc        \
    source/rotate_argb.cc       \
    source/rotate_common.cc     \
    source/rotate_mips.cc       \
    source/rotate_neon64.cc     \
    source/rotate_gcc.cc        \
    source/row_any.cc           \
    source/row_common.cc        \
    source/row_mips.cc          \
    source/row_neon64.cc        \
    source/row_gcc.cc	        \
    source/scale.cc             \
    source/scale_any.cc         \
    source/scale_argb.cc        \
    source/scale_common.cc      \
    source/scale_mips.cc        \
    source/scale_neon64.cc      \
    source/scale_gcc.cc         \
    source/video_common.cc

# TODO(fbarchard): Enable mjpeg encoder.
#   source/mjpeg_decoder.cc
#   source/convert_jpeg.cc
#   source/mjpeg_validate.cc

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_SRC_FILES += \
        source/compare_neon.cc.neon    \
        source/rotate_neon.cc.neon     \
        source/row_neon.cc.neon        \
        source/scale_neon.cc.neon
endif

ifeq ($(TARGET_ARCH_ABI),mips)
    LOCAL_CFLAGS += -DLIBYUV_MSA
    LOCAL_SRC_FILES += \
        source/row_msa.cc    \
        source/scale_msa.cc  \
        source/rotate_msa.cc
endif

    LOCAL_CFLAGS += -DLIBYUV_NEON -DNDEBUG -static -fPIC -O3 -march=armv8-a -mtune=cortex-a57.cortex-a53 -ftree-vectorize -ffast-math
	LOCAL_ARM_NEON := true
	LOCAL_ARM_MODE := arm

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include

LOCAL_MODULE := libyuv
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)

