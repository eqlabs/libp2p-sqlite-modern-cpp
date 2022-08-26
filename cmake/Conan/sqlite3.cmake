add_conan_package(sqlite3 3.39.2)
find_package(SQLite3 MODULE REQUIRED)
include_directories(${SQLite3_INCLUDE_DIRS})
