list(APPEND SAN_FLAGS
    -fsanitize=address
    -fsanitize-address-use-after-scope
    )

set(ENV{ASAN_OPTIONS} verbosity=1:debug=1:detect_leaks=1:check_initialization_order=1:alloc_dealloc_mismatch=true:use_odr_indicator=true)
