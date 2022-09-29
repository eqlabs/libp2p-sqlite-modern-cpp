list(APPEND SAN_FLAGS
    -fsanitize=leak
    )

set(ENV{LSAN_OPTIONS} detect_leaks=1)

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "sanitize-leak")
