if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/0.18.1/conan.cmake"
                "${CMAKE_BINARY_DIR}/conan.cmake"
                TLS_VERIFY ON)
endif()

# For some weird reason conan.cmake doesn't fall-back to Debug in case of CMAKE_BUILD_TYPE
# not being set. So have to set it explicitly
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

function(add_conan_package PACKAGE_NAME PACKAGE_VERSION)
    set(PACKAGE_DIR "${CMAKE_BINARY_DIR}/${PACKAGE_NAME}")
    file(MAKE_DIRECTORY "${PACKAGE_DIR}")
    # We have to use a hack to change CMAKE_CURRENT_BINARY_DIR because
    # inside `conan_cmake_install` conanfile.txt directory is hardcoded to
    # CMAKE_CURRENT_BINARY_DIR. We use a separate conan run for each 3rdparty
    # because we want to make configuring different 3rdparties independently.
    # That's why we need to change directory here.
    # TODO: make a pull request to conan-cmake to make conanfile.txt path configurable.
    set(PREV_CMAKE_CURRENT_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}")
    set(CMAKE_CURRENT_BINARY_DIR "${PACKAGE_DIR}")
    cmake_parse_arguments(ADD_CONAN_PACKAGE "" "" "CONFIG_OPTIONS" ${ARGN})

    conan_cmake_configure(REQUIRES ${PACKAGE_NAME}/${PACKAGE_VERSION}
        GENERATORS cmake_find_package
        OPTIONS ${MY_INSTALL_CONFIG_OPTIONS})

    conan_cmake_autodetect(CONAN_SETTINGS)
    conan_cmake_install(PATH_OR_REFERENCE .
        BUILD missing
        REMOTE conancenter
        SETTINGS ${CONAN_SETTINGS})
    set(CMAKE_CURRENT_BINARY_DIR "${PREV_CMAKE_CURRENT_BINARY_DIR}")
    list(APPEND CMAKE_MODULE_PATH "${PACKAGE_DIR}")
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
endfunction()
