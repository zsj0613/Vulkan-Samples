# Copyright (C) 2023 by Arm Limited.
#
# SPDX-License-Identifier: MIT
#

IF((NOT DEFINED CACHE{ANDROID_NDK}) AND (DEFINED ENV{ANDROID_NDK_HOME}))
    SET(ANDROID_NDK                 "$ENV{ANDROID_NDK_HOME}" CACHE FILEPATH "" FORCE)
ENDIF()

IF((NOT DEFINED CACHE{ANDROID_NDK}) OR (NOT IS_DIRECTORY "$CACHE{ANDROID_NDK}"))
    MESSAGE(FATAL_ERROR "ANDROID_NDK is not defined or valid ($CACHE{ANDROID_NDK})")
ENDIF()

IF((NOT DEFINED CACHE{ANDROID_ABI}) OR ("$CACHE{ANDROID_ABI}" STREQUAL ""))
    MESSAGE(FATAL_ERROR "ANDROID_ABI is not defined ($CACHE{ANDROID_ABI})")
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_NDK_TOOLCHAIN_FILE})
    SET(ANDROID_NDK_TOOLCHAIN_FILE  "${ANDROID_NDK}/build/cmake/android.toolchain.cmake" CACHE FILEPATH "" FORCE)
ENDIF()

IF((NOT EXISTS "$CACHE{ANDROID_NDK_TOOLCHAIN_FILE}") OR (IS_DIRECTORY "$CACHE{ANDROID_NDK_TOOLCHAIN_FILE}"))
    MESSAGE(FATAL_ERROR "ANDROID_NDK_TOOLCHAIN_FILE is invalid ($CACHE{ANDROID_NDK_TOOLCHAIN_FILE})")
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_PLATFORM})
    IF(DEFINED CACHE{ANDROID_NATIVE_API_LEVEL})
        SET(ANDROID_PLATFORM            "$CACHE{ANDROID_NATIVE_API_LEVEL}" CACHE STRING "" FORCE)
    ELSE()
        SET(ANDROID_PLATFORM            "android-21" CACHE STRING "" FORCE)
    ENDIF()
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_NATIVE_API_LEVEL})
    SET(ANDROID_NATIVE_API_LEVEL    "$CACHE{ANDROID_PLATFORM}" CACHE STRING "" FORCE)
ENDIF()

IF(NOT ("$CACHE{ANDROID_PLATFORM}" STREQUAL "$CACHE{ANDROID_NATIVE_API_LEVEL}"))
    MESSAGE(FATAL_ERROR "Both ANDROID_NATIVE_API_LEVEL and ANDROID_PLATFORM are set and have different values")
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_NO_UNDEFINED})
    SET(ANDROID_NO_UNDEFINED        ON CACHE BOOL "" FORCE)
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_LD})
    SET(ANDROID_LD                  "default" CACHE STRING "" FORCE)
ENDIF()

IF(NOT DEFINED CACHE{ANDROID_STL})
    SET(ANDROID_STL                  "c++_static" CACHE STRING "" FORCE)
ENDIF()

INCLUDE("$CACHE{ANDROID_NDK_TOOLCHAIN_FILE}")