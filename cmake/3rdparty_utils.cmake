set(PACKAGE_MANAGER "Hunter" CACHE STRING "Package manager for 3rdparties")

set(SUPPORTED_PACKAGE_MANAGERS "Hunter" "Conan")
if (NOT ${PACKAGE_MANAGER} IN_LIST SUPPORTED_PACKAGE_MANAGERS)
    message(FATAL_ERROR "Uknown package manager specified: \"${PACKAGE_MANAGER}\". Valid options: ${SUPPORTED_PACKAGE_MANAGERS}")
endif()

include("${CMAKE_SOURCE_DIR}/cmake/${PACKAGE_MANAGER}/init.cmake")

macro(add_3rdparty PACKAGE_NAME)
    include("${CMAKE_SOURCE_DIR}/cmake/${PACKAGE_MANAGER}/${PACKAGE_NAME}.cmake")
endmacro()
