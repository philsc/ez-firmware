filegroup(
	name = "empty",
)

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8|gcc": "cc-compiler-k8-gcc",
        "k8|clang": "cc-compiler-k8-clang",
        "avr|gcc": "cc-compiler-avr-gcc",
    },
    visibility = ["//visibility:public"],
)

cc_toolchain(
    name = "cc-compiler-k8-gcc",
    all_files = ":empty",
    compiler_files = ":empty",
    cpu = "k8",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":empty",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
    visibility = ["//visibility:public"],
)

cc_toolchain(
    name = "cc-compiler-k8-clang",
    all_files = "//tools/cpp/clang:all",
    compiler_files = "//tools/cpp/clang:all",
    cpu = "k8",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = "//tools/cpp/clang:all",
    objcopy_files = "//tools/cpp/clang:all",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
    visibility = ["//visibility:public"],
)

cc_toolchain(
    name = "cc-compiler-avr-gcc",
    all_files = "//tools/cpp/avr_gcc:all",
    compiler_files = "//tools/cpp/avr_gcc:all",
    cpu = "avr",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = "//tools/cpp/avr_gcc:all",
    objcopy_files = "//tools/cpp/avr_gcc:all",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
    visibility = ["//visibility:public"],
)
