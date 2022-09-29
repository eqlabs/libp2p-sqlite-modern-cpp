list(APPEND SAN_FLAGS
     -fsanitize=thread
    )

# add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-fsanitize=thread")
# add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-fsanitize=thread")
