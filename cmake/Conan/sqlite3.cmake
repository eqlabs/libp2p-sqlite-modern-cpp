add_conan_package(sqlite3 3.39.2)
find_package(SQLite3 MODULE REQUIRED)
include_directories(${SQLite3_INCLUDE_DIRS})

set_target_properties(SQLite::SQLite3 PROPERTIES IMPORTED_GLOBAL TRUE)
add_library(sqlite3::sqlite3 ALIAS SQLite::SQLite3)
