#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

cmake_minimum_required(VERSION 3.12)

include("${CMAKE_CURRENT_LIST_DIR}/cmake/3rdparty_utils.cmake")

project("SQLiteModernCpp"
  LANGUAGES CXX
  VERSION 3.2.1
  )

add_3rdparty(sqlite3)

add_library(${PROJECT_NAME} INTERFACE)
target_include_directories(
  ${PROJECT_NAME} INTERFACE
  $<BUILD_INTERFACE:"${CMAKE_CURRENT_SOURCE_DIR}/hdr">
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDE_DIR}>
)
target_link_libraries(${PROJECT_NAME} INTERFACE sqlite3::sqlite3)
target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_17)

include(GNUInstallDirs)

# (https://github.com/forexample/package-example)

set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")

set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}::")

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${version_config}" COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
  "cmake/Config.cmake.in"
  "${project_config}"
  INSTALL_DESTINATION "${config_install_dir}"
)

install(
  TARGETS ${PROJECT_NAME}
  EXPORT "${TARGETS_EXPORT_NAME}"
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FRAMEWORK DESTINATION ${CMAKE_INSTALL_PREFIX}
)

install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/hdr/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  FILES "${project_config}" "${version_config}"
  DESTINATION "${config_install_dir}"
)

install(
  EXPORT "${TARGETS_EXPORT_NAME}"
  NAMESPACE "${namespace}"
  DESTINATION "${config_install_dir}"
)
