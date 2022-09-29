list(APPEND SAN_FLAGS
    -fsanitize=undefined
    -fno-omit-frame-pointer
    )

set(ENV{UBSAN_OPTIONS} print_stacktrace=1)
